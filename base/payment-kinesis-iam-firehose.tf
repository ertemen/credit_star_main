

resource "aws_iam_role" "firehose_dwh_payment" {
  name = "dwh-payment${var.staging_suffix}"
  assume_role_policy = data.aws_iam_policy_document.firehose_dwh_payment.json
  tags = local.tags
}

data "aws_iam_policy_document" "firehose_dwh_payment" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"]

    resources = [
      aws_s3_bucket.events.arn,
      "${local.s3.dwh_cstar_error_s3_arn}/*",
      "${local.s3.dwh_cstar_error_s3_arn}/*"
    ]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
      "logs:Describe*",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "cloudwatch:PutMetricData",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "glue:GetTable",
      "glue:GetTableVersion",
      "glue:GetTableVersions"
    ]

    resources = [
      aws_glue_catalog_table.dwh_payment.arn,
      aws_glue_catalog_database.cstar_dwh.arn,
      "arn:aws:glue:${var.region}:${data.aws_caller_identity.current.account_id}:catalog"
    ]
  }

  statement {
    actions = [
      "kinesis:Get*",
      "kinesis:Describe*"
    ]

    resources = [
      aws_kinesis_stream.dwh_payment.arn
    ]
  }

  statement {
    actions = [
      "kinesis:ListStreams"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "firehose_dwh_payment" {
  name = "dwh-payment${var.staging_suffix}"
  policy = data.aws_iam_policy_document.firehose_dwh_payment.json
  role = aws_iam_role.firehose_dwh_payment.id
}

