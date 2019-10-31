sam init --dependency-manager npm --runtime nodejs10.x --name hello-world
sam build
sam package --output-template packaged.yaml --s3-bucket sam-state
sam publish --template-file packaged.yaml --region us-east-1
sam deploy --template-file packaged.yaml --region us-east-1 --capabilities CAPABILITY_IAM --stack-name aws-sam-hello-world
aws cloudformation describe-stacks --stack-name aws-sam-hello-world --region us-east-1 --query "Stacks[].Outputs"
sam logs -t --name aws-sam-hello-world-HelloWorldFunction-1LPU9ULDMXTHS --region us-east-1


sam local start-api
sam local invoke "HelloWorldFunction" -e events/event.json
sam local generate-event apigateway aws-proxy --body "" --path "hello" --method GET > events/api-event.json
diff events/api-event.json events/event.json
sam local invoke "HelloWorldFunction" -e events/api-event.json

aws cloudformation delete-stack --stack-name aws-sam-hello-world --region us-east-1