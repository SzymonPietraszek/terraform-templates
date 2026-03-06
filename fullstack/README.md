Prerequisites:
1. Create an AWS account
2. Run "aws configure" to set access key id and secret access key
3. Create a github fastAPI project with app folder with all the code, app/main.py file with mangun handler (or change mangun_handler_path) and requirements.txt file in a root folder
4. Run docker daemon
5. Create a cloudflare account (account_id)
6. Create an Account API token with such permission:
Account - Access: Identity Providers:Edit, Cloudflare Pages:Edit, Access: Apps and Policies:Edit
(api_token)
7. Create a github repo with frontend code (see cloudflare-pages-example)
8. Integrate github with cloudflare https://developers.cloudflare.com/pages/get-started/git-integration/
9. Create a client id and a client secret for using Google as an identity provider. Follow this tutorial until step 9:
https://developers.cloudflare.com/cloudflare-one/integrations/identity-providers/google/
(google_client_id, google_client_secret)


terraform -chdir=fullstack init
terraform -chdir=fullstack apply -var-file=../../terraform-vars/fullstack.tfvars

You need to wait for a minute or two before a page will be running.
Then open the output url and test if you can login.

You can create a request to backend in Insomnia to $(terraform -chdir=aws-lambda output url) with Auth: AWS IAM set with
terraform -chdir=fullstack console
> module.backend.url
> nonsensitive(module.backend.access_key.id)
> nonsensitive(module.backend.access_key.secret)
Region: eu-central-1
Service: lambda

terraform -chdir=fullstack destroy -var-file=../../terraform-vars/fullstack.tfvars
