# How to use
Inside of each folder there is a terraform configuration with README file describing how to use it. Follow the instructions to deploy.

For each terraform configuration there are prerequisites specified in README. Some accounts like aws or cloudflare require a credit card but if the traffic is relatively low, there should be no chanrges (check free tiers).

To apply these terraform configurations you need to create a tfvars file with values set from prerequisites or custom made. I used a separate folder to keep tfvars. If you prefer you might change some command paths from README but no terraform code changes should be needed. You should run commands from the repo root folder (terraform-templates) or change the commands.
