

resource "aws_glue_catalog_table" "dwh_payment" {
  name = "dwh_payment"

  database_name = aws_glue_catalog_database.cstar_dwh.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    classification = "parquet"
    "projection.enabled" = "true"
    "projection.day.digits" = "2"
    "projection.day.range" = "01,31"
    "projection.day.type" = "integer"
    "projection.month.digits" = "2"
    "projection.month.range" = "01,12"
    "projection.month.type" = "integer"
    "projection.year.range" = "2020,2030"
    "projection.year.type" = "integer"
  }

  partition_keys {
    name = "year"
    type = "int"
  }

  partition_keys {
    name = "month"
    type = "int"
  }

  partition_keys {
    name = "day"
    type = "int"
  }

  storage_descriptor {
    location = "s3://${local.s3.dwh_cstar_payment_s3_path}"
    input_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    compressed = false

    ser_de_info {
      name = "JsonSerDe"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "data"
      type = "struct<id:bigint,loan_id:bigint,amount:decimal(18,4),principle:decimal(18,4),interest:decimal(18,4),status:string,created_on:date>"
    }

    columns {
      name = "metadata"
      type = "string"
    }
  }
}