variable "tf_state_bucket" {
  description = "Name of S3 bucket in AWS for storing TF state"
  default     = "devops-rainbow-app-state"
}

variable "tf_state_lock_table" {
  description = "Name of DynamoDB table for TF state locking"
  default     = "devops-craigrainbows-app-tf-lock"
}

variable "project" {
  description = "Project name for tagging resources"
  default     = "rainbowtext-app"
}

variable "contact" {
  description = "Contact name for tagging resources"
  default     = "harriajames98@gmail.com"
}

