locals {
  lifecycle_configuration_rules = [{
    enabled = true # bool
    id      = "v2rule"

    abort_incomplete_multipart_upload_days = 1 # number

    filter_and = null
    expiration = {
      days = var.object_expiration_days # integer > 0
    }
    noncurrent_version_expiration = {
      newer_noncurrent_versions = 3                                      # integer > 0
      noncurrent_days           = var.noncurrent_version_expiration_days # integer >= 0
    }
    transition = [{
      days          = var.object_transition_standardia_days # integer >= 0
      storage_class = "STANDARD_IA"                         # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
      },
      {
        days          = var.object_transition_onezoneia_days # integer >= 0
        storage_class = "ONEZONE_IA"                         # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
    }]
    noncurrent_version_transition = [{
      newer_noncurrent_versions = 3                                    # integer >= 0
      noncurrent_days           = var.object_transition_onezoneia_days # integer >= 0
      storage_class             = "ONEZONE_IA"                         # string/enum, one of GLACIER, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, DEEP_ARCHIVE, GLACIER_IR.
    }]
  }]
}

# Retrieve the current AWS account ID
data "aws_caller_identity" "current" {}