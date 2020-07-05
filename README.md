# Onboard websites on Imperva Cloud WAF using Terraform and CSV

Tested this on:
```
$ terraform --version
Terraform v0.12.26
```

This main file lets you perform the following functions in one go:

1. Utilizing the csvdecode, it allows you to use a CSV file as an input for all the information instead of adding all that information manually in main.tf file. Have a look at **domain_information.csv** as an example. File name can be anything since you will input the file name during terraform apply.
2. Automatically create a cert validation record in your route53 zone.
3. Automatically create a CNAME record in your route53 zone pointing to Imperva CDN. In case you don't wish to do this during onboarding comment the resource "cname-record".  **This won't work until the next update due to an open issue tracked in the link given below**

In addition to that you need to create a **secrets.tfvars** file with the following contents which again you need to input during terraform apply:

```
#Imperva API Information
api_id  = "xxx"
api_key = "xxx"

#AWS API Information
region = "<region of your choice>"
access_key = "xxx"
secret_key = "xxx"
```

Note: This implementation uses the plugin from:

https://github.com/imperva/terraform-provider-incapsula

The incapsula provider available on hashicorp website doesn't support few features like setting up data region:

https://www.terraform.io/docs/providers/incapsula/r/site.html

If you wish to use terraform cloud, be sure to comment out data region from main.

Look at the following link for open issues:

https://github.com/imperva/terraform-provider-incapsula/issues
