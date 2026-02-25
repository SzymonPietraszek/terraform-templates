Prerequisites:
1. Create an AWS account
2. Run "aws configure" to set access key id and secret access key
3. Create a github fastAPI project with app folder with all the code, app/main.py file with mangun handler (or change mangun_handler_path) and requirements.txt file in a root folder


terraform -chdir=aws-lambda init
terraform -chdir=aws-lambda apply -var-file=../../terraform-vars/aws-lambda.tfvars

you can create a GET request in Insomnia to $(terraform -chdir=aws-lambda output url) with Auth: AWS IAM set with
Access Key ID: terraform -chdir=aws-lambda output access_key
Secret Access Key: terraform -chdir=aws-lambda output secret_key
Region: eu-central-1
Service: lambda

aws logs tail "/aws/lambda/fastapi-lambda" --follow

terraform -chdir=aws-lambda destroy -var-file=../../terraform-vars/aws-lambda.tfvars
