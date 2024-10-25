resource "aws_iam_role" "lambda_role" {
  name = "lambda_assistente_viagem_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_logging_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "logs:*"
        Resource = "*"
        Effect = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "my_lambda" {
  function_name    = var.lambda_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.10"  # Alterar para a versão desejada
  timeout          = 10
  source_code_hash = data.archive_file.script_lambda.output_base64sha256
  # source_code_hash = filebase64sha256("script/lambda_function.py")

  filename         = "./files/${var.lambda_name}.zip"

  depends_on = [
    aws_iam_role_policy_attachment.lambda_role_policy_attachment,
  ]
}

## Arquivos Lambda de SLA
data "archive_file" "script_lambda" {
  type        = "zip"
  source_file = "./script/lambda_function.py"
  output_path = "./files/${var.lambda_name}.zip"
}

# resource "null_resource" "lambda_zip" {
#   provisioner "local-exec" {
#     command = "zip -r ./lambda_function.zip ./script/lambda_function.py"
#   }
# }

output "lambda_function_arn" {
  value = aws_lambda_function.my_lambda.arn
}
