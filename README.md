# Automating onboarding of websites on Imperva Cloud WAF using Terraform

This lets you use a CSV file as an input for all the information instead of adding all that information manually in main.tf file.

domain_information.csv is the file that you need to share with your customer. They'll fill this file with the domain they would like to onboard. File name can be anything since you will input the file name during apply.

In addition to that you need to create a secrets.tfvars file with the following contents:
#Imperva API Information
api_id  = "xxx"
api_key = "xxx"

#AWS API Information
region = "<region of your choice>" 
access_key = "xxx"
secret_key = "xxx"