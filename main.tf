terraform {
  required_providers {
    kypo = {
      source  = "vydrazde/kypo"
      version = ">= 0.1.0"
    }
  }
}

resource "kypo_sandbox_definition" "definition" {
  url = startswith(var.project_url, "git@") ? var.project_url : replace(var.project_url, "/^(https?://)?([^/]+)/(.+?)(\\.git)?$/", "git@$2:$3.git")
  rev = var.rev
}

resource "kypo_sandbox_pool" "pool" {
  definition = {
    id = kypo_sandbox_definition.definition.id
  }
  max_size = local._pool_size

  lifecycle {
    precondition {
      condition     = local._pool_size >= var.sandbox_count
      error_message = "pool_size must be bigger or equal to sandbox_count."
    }
  }
}

resource "kypo_sandbox_allocation_unit" "sandbox" {
  pool_id                       = kypo_sandbox_pool.pool.id
  warning_on_allocation_failure = true

  count = var.sandbox_count
}

resource "null_resource" "check" {
  triggers = {
    stages = join(", ", kypo_sandbox_allocation_unit.sandbox[count.index].allocation_request.stages)
  }

  lifecycle {
    postcondition {
      condition     = join(", ", kypo_sandbox_allocation_unit.sandbox[count.index].allocation_request.stages) == "FINISHED, FINISHED, FINISHED"
      error_message = "Sandbox allocation has finished with error."
    }
  }
  count = var.sandbox_count
}

data "kypo_sandbox_request_output" "output" {
  id    = kypo_sandbox_allocation_unit.sandbox[each.value.index].allocation_request.id
  stage = each.value.stage

  for_each = local.for_sandbox_stage
}

resource "local_sensitive_file" "output" {
  content         = data.kypo_sandbox_request_output.output["${each.value.index}-${each.value.stage}"].result
  filename        = "${var.output_directory}/p${kypo_sandbox_pool.pool.id}-s${kypo_sandbox_allocation_unit.sandbox[each.value.index].id}-${each.value.stage}.txt"
  file_permission = "666"

  for_each = local.for_sandbox_stage
}
