locals {
  tags = {
    Account: var.account
    Environment: var.environment
    ProjectName: var.project_name
    SubProjectName: var.sub_project_name
    SourceRepository: var.source_repository
    Terraform: true
  }





  s3 = {
    ### --- S3 ERROR --- BEGIN
    # --- S3 LANDING ERROR --- BEGIN
    dwh_cstar_error_s3_arn = "${aws_s3_bucket.events.arn}/${var.dwh_cstar_error_stream_prefix}/${var.dwh_cstar_error_stream_prefix}"
    dwh_cstar_error_s3_path = "${aws_s3_bucket.events.id}/${var.dwh_cstar_error_stream_prefix}/${var.dwh_cstar_error_stream_prefix}"
    dwh_cstar_error_s3_folder = "${var.dwh_cstar_error_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    # --- S3 LANDING ERROR --- END
    ### --- S3 ERROR --- END


    dwh_cstar_users_s3_arn = "${aws_s3_bucket.events.arn}/${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    dwh_cstar_users_s3_path = "${aws_s3_bucket.events.id}/${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    dwh_cstar_users_s3_folder = "${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    dwh_cstar_users_s3_error_arn = "${aws_s3_bucket.events.arn}/${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    dwh_cstar_users_s3_error_path = "${aws_s3_bucket.events.id}/${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"
    dwh_cstar_users_s3_error_folder = "${var.users_cstar_stream_prefix}/${var.dwh_cstar_users_s3_prefix}"

    dwh_cstar_loan_s3_arn = "${aws_s3_bucket.events.arn}/${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"
    dwh_cstar_loan_s3_path = "${aws_s3_bucket.events.id}/${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"
    dwh_cstar_loan_s3_folder = "${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"
    dwh_cstar_loan_s3_error_arn = "${aws_s3_bucket.events.arn}/${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"
    dwh_cstar_loan_s3_error_path = "${aws_s3_bucket.events.id}/${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"
    dwh_cstar_loan_s3_error_folder = "${var.loan_cstar_stream_prefix}/${var.dwh_cstar_loan_s3_prefix}"

    dwh_cstar_payment_s3_arn = "${aws_s3_bucket.events.arn}/${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"
    dwh_cstar_payment_s3_path = "${aws_s3_bucket.events.id}/${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"
    dwh_cstar_payment_s3_folder = "${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"
    dwh_cstar_payment_s3_error_arn = "${aws_s3_bucket.events.arn}/${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"
    dwh_cstar_payment_s3_error_path = "${aws_s3_bucket.events.id}/${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"
    dwh_cstar_payment_s3_error_folder = "${var.payment_cstar_stream_prefix}/${var.dwh_cstar_payment_s3_prefix}"


}}



