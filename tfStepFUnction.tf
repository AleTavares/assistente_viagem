resource "aws_iam_role" "aws_stf_role" {
  name               = "aws-stf-role"
  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":"sts:AssumeRole",
         "Principal":{
            "Service":[
                "states.amazonaws.com"
            ]
         },
         "Effect":"Allow",
         "Sid":"StepFunctionAssumeRole"
      }
   ]
}
EOF
}

resource "aws_iam_role_policy" "step_function_policy" {
  name = "aws-stf-policy"
  role = aws_iam_role.aws_stf_role.id

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Action":[
                "bedrock:InvokeModel",
                "lambda:*"     
            ],
         "Effect":"Allow",
         "Resource":["*"]
      }
  ]
}

EOF
}

resource "aws_sfn_state_machine" "aws_step_function_workflow" {
  name       = "assistente-viagem"
  role_arn   = aws_iam_role.aws_stf_role.arn
  definition = <<EOF
{
    "Comment":"Este fluxo executa uma lmabda informando uma cidade e estado e aciona um modelo do Bedrock para informar os pontos turisticos",
    "StartAt": "Lambda Invoke",
    "States": {
        "Lambda Invoke": {
            "Type": "Task",
            "Resource": "arn:aws:states:::lambda:invoke",
            "Parameters": {
                "FunctionName": "arn:aws:lambda:us-east-1:353818015911:function:${var.lambda_name}:$LATEST",
                "Payload": {
                    "cidade": "Atibaia",
                    "uf": "SP"
                }
            },
            "Retry": [
                {
                    "ErrorEquals": [
                        "Lambda.ServiceException",
                        "Lambda.AWSLambdaException",
                        "Lambda.SdkClientException",
                        "Lambda.TooManyRequestsException"
                    ],
                    "IntervalSeconds": 1,
                    "MaxAttempts": 3,
                    "BackoffRate": 2
                }
            ],
            "Next": "Pass",
            "ResultPath": "$.LambdaOutput"
        },
        "Pass": {
            "Type": "Pass",
            "Parameters": {
                "Prompt.$": "$.LambdaOutput.Payload.prompt"
            },
            "Next": "Bedrock InvokeModel"
        },
        "Bedrock InvokeModel": {
            "Type": "Task",
            "Resource": "arn:aws:states:::bedrock:invokeModel",
            "Parameters": {
                "ModelId": "arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-sonnet-20240229-v1:0",
                    "Body": {
                        "anthropic_version": "bedrock-2023-05-31",
                        "max_tokens": 200,
                        "messages": [
                            {
                                "role": "user",
                                "content": [
                                    {
                                        "type": "text",
                                        "text.$": "$.Prompt"
                                    }
                                ]
                            }
                        ]
                    }
            },
            "End": true
        }
    }
}
EOF

}
