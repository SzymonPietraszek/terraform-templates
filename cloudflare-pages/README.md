Prerequisites:
1. Create a cloudflare account (account_id)
2. Create an Account API token with such permission:
Account - Access: Identity Providers:Edit, Cloudflare Pages:Edit, Access: Apps and Policies:Edit
(api_token)
3. Create a github repo with frontend code (see cloudflare-pages-example)
4. Integrate github with cloudflare https://developers.cloudflare.com/pages/get-started/git-integration/
5. Create a client id and a client secret for using Google as an identity provider. Follow this tutorial until step 9:
https://developers.cloudflare.com/cloudflare-one/integrations/identity-providers/google/
(google_client_id, google_client_secret)


terraform -chdir=cloudflare-pages init
terraform -chdir=cloudflare-pages apply -var-file=../../terraform-vars/cloudflare-pages.tfvars
Open the output url and test if you can login
terraform -chdir=cloudflare-pages destroy -var-file=../../terraform-vars/cloudflare-pages.tfvars
