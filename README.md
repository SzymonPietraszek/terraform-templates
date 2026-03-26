# This repo is archived!
The work done in this repo was used in https://github.com/free-website-framework


# Goal
There are 3 separate terrafrom configurations in this repo: aws-lambda, cloudflare-pages and fullstack. These configurations can be used as a blueprint for internet accessible projects without public access for free. So if you try to deploy a simple app that you wish you can access on any device anywhere but requires authentication, you can use these configurations. A fullstack configuration is a composition of aws-lambda backend and cloudflare-pages frontend with main focus on secure connection between two. 

There are two other repos related to these configurations: cloudflare-pages-example and lambda-fastapi. Both has branches related to each terraform configuration for deployment.

# Fullstack diagram

![Diagram](docs/diagram.svg)

# How to use
Inside of each folder there is a terraform configuration with README file describing how to use it. Follow the instructions to deploy.

For each terraform configuration there are prerequisites specified in README. Some accounts like aws or cloudflare require a credit card but if the traffic is relatively low, there should be no chanrges (check free tiers).

To apply these terraform configurations you need to create a tfvars file with values set from prerequisites or custom made. I used a separate folder to keep tfvars. If you prefer you might change some command paths from README but no terraform code changes should be needed. You should run commands from the repo root folder (terraform-templates) or change the commands.
