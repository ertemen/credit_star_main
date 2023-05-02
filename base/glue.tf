resource "aws_glue_catalog_database" "cstar_dwh" {
  name = "cstar_dwh"
  description = "Terraform = True, SourceRepository = ${var.source_repository}"
}