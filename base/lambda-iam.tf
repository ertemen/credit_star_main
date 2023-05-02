
resource "aws_iam_role" "lambda_cstar_transform_job_glue_role" {
  name = "lambda-cstar-transform-job-glue-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_cstar_transform_job_glue_policy" {
  name_prefix = "lambda-cstar-transform-job-glue-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "glue:StartJobRun"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_glue_cstar_transform_job_glue_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_cstar_transform_job_glue_policy.arn
  role       = aws_iam_role.lambda_cstar_transform_job_glue_role.name
}
