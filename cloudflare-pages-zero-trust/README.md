Prerequisites:
1. All the requirements from cloudflare-pages but with an Account API token with such permission:
Account - Access: Identity Providers:Edit, Cloudflare Pages:Edit, Access: Apps and Policies:Edit
2. Create a client id and a client secret for using Google as an identity provider. Follow this tutorial until step 9:
https://developers.cloudflare.com/cloudflare-one/integrations/identity-providers/google/
(google_client_id, google_client_secret)


terraform -chdir=cloudflare-pages-zero-trust init
terraform -chdir=cloudflare-pages-zero-trust apply -var-file=../../terraform-vars/cloudflare-pages-zero-trust.tfvars
Open the output url and test if you can login
terraform -chdir=cloudflare-pages-zero-trust destroy -var-file=../../terraform-vars/cloudflare-pages-zero-trust.tfvars
