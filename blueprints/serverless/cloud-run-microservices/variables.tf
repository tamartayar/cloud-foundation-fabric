/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "custom_domain" {
  description = "Custom domain for the Load Balancer."
  type        = string
  default     = "server.example.org"
}

variable "image" {
  description = "Container image to deploy."
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "ip_ranges" {
  description = "IPs or IP ranges used by VPCs."
  type        = map(map(string))
  default = {
    main = {
      subnet            = "10.0.1.0/24"
      subnet_proxy      = "10.10.0.0/24"
      subnet_vpc_access = "10.10.10.0/28"
      subnet_vpc_direct = "10.8.0.0/28"
      psc_addr          = "10.0.0.100"
    }
  }
}

variable "prj_main_create" {
  description = "Parameters for the creation of the main project."
  type = object({
    billing_account_id = string
    parent             = string
  })
  default = null
}

variable "prj_main_id" {
  description = "Main Project ID."
  type        = string
}

variable "prj_svc1_create" {
  description = "Parameters for the creation of service project 1."
  type = object({
    billing_account_id = string
    parent             = string
  })
  default = null
}

variable "prj_svc1_id" {
  description = "Service Project 1 ID."
  type        = string
  default     = null
}

variable "region" {
  description = "Cloud region where resources will be deployed."
  type        = string
  default     = "europe-west1"
}