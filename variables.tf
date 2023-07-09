variable "project_url" {
  type        = string
  description = "Url to Git repository with sandbox definition, as obtained by Clone with SSH or HTTPS."
}

variable "rev" {
  type        = string
  description = "Git revision of the Git repository from project_url to use."
}

variable "sandbox_count" {
  type        = number
  default     = 1
  description = "The number of sandboxes to be allocated."
}

variable "pool_size" {
  type        = number
  default     = null
  description = "The maximum number of sandboxes that can be allocated in a pool. Defaults to sandbox_count."
}

variable "stages" {
  type        = set(string)
  default     = ["user-ansible", "networking-ansible", "terraform"]
  description = "Set of stages whose output from sandbox allocation will be saved to files in output_directory. One file per each combination of stage and sandbox."
  validation {
    condition     = alltrue([for stage in var.stages : contains(["user-ansible", "networking-ansible", "terraform"], stage)])
    error_message = "Valid values in set are (user-ansible, networking-ansible, terraform)."
  }
}

variable "output_directory" {
  type        = string
  default     = "outputs"
  description = "The directory where files with outputs will be created."
}

locals {
  _pool_size = var.pool_size != null ? var.pool_size : var.sandbox_count
  for_sandbox_stage = { for pair in setproduct(range(var.sandbox_count), var.stages) : "${pair[0]}-${pair[1]}" =>
    {
      index = pair[0]
      stage = pair[1]
    }
  }
}
