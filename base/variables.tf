# --- Generic Variables --- BEGIN
variable "account" {}
variable "region" {}
variable "project_name" {}
variable "project_name_underscored" {}
variable "sub_project_name" {}
variable "environment" {}
variable "source_repository" {}
variable "staging_suffix" {}
# --- Generic Variables --- END




# --- Firehose Common Variables --- BEGIN
variable "firehose_common_prefix" {}
variable "firehose_error_prefix" {}
# --- Firehose Common Variables --- END

# --- DMS Variables --- BEGIN
variable "s3_cstar_bucket_folder" {}

variable "cstar_postgres_db_name" {}

variable "vpc_id" {}
variable "subnet_priv_1a_id" {}
variable "subnet_priv_1b_id" {}

