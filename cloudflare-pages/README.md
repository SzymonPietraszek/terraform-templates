Prerequisites:
1. Create a cloudflare account (account_id)
2. Create an Account API token with such permission:
Account - Cloudflare Pages:Edit
(api_token)
3. Create a github repo with frontend code (see cloudflare-pages-example)
4. Integrate github with cloudflare https://developers.cloudflare.com/pages/get-started/git-integration/


terraform -chdir=cloudflare-pages init
terraform -chdir=cloudflare-pages apply -var-file=../../terraform-vars/cloudflare-pages.tfvars
curl "https://$(terraform -chdir=cloudflare-pages output -raw subdomain)"
terraform -chdir=cloudflare-pages destroy -var-file=../../terraform-vars/cloudflare-pages.tfvars
