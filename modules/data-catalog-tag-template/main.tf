/**
* Copyright 2024 Google LLC
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

locals {
  primitive_types = ["DOUBLE", "STRING", "BOOL", "TIMESTAMP"]
  enum_type       = ["ENUM"]
}

resource "google_data_catalog_tag_template" "default" {
  # for_each        = local.tag_template
  project         = var.project_id
  region          = var.region
  tag_template_id = lower(var.name)
  display_name    = var.display_name
  force_delete    = var.force_delete

  dynamic "fields" {
    for_each = { for field in var.tag_template_fields : field["field_id"] => field }
    content {
      field_id     = fields.value["field_id"]
      display_name = fields.value["display_name"]
      description  = fields.value["description"]
      is_required  = fields.value["is_required"]
      order        = fields.value["order"]
      dynamic "type" {
        for_each = { for idx, prim_type in [fields.value["type"]] : idx => prim_type if contains(local.primitive_types, prim_type) }
        content {
          primitive_type = type.value
        }
      }
      dynamic "type" {
        for_each = { for idx, enum_type in [fields.value["type"]] : idx => enum_type if contains(local.enum_type, enum_type) }
        content {
          enum_type {
            dynamic "allowed_values" {
              for_each = toset(fields.value["values"])
              content {
                display_name = allowed_values.value
              }
            }
          }
        }
      }
    }
  }
}
