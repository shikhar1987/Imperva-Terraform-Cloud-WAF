provider "incapsula" {
  api_id  = var.api_id
  api_key = var.api_key
}
provider "aws" {
  region = var.region
  //access_key = var.access_key
  //secret_key = var.secret_key
}
data "aws_route53_zone" "zone" {
  name = "securitytestingsolutions.com."
}
locals {
  application_information = csvdecode(file(var.input_file))
}

resource "incapsula_site" "devops-sites" {
    count = length(local.application_information)

  domain                 = local.application_information[count.index].domain
  account_id             = local.application_information[count.index].account_id
  ref_id                 = "123456"
  force_ssl              = false //local.application_information[count.index].force_ssl
  data_storage_region    = local.application_information[count.index].data_storage_region
  send_site_setup_emails = local.application_information[count.index].send_site_setup_emails
  site_ip                = local.application_information[count.index].site_ip
  ignore_ssl            = true
  remove_ssl            = true
}

/*resource "aws_route53_record" "cert-validation-record" {

  depends_on = [incapsula_site.devops-sites]
  allow_overwrite = true
  name = data.aws_route53_zone.zone.name
  type = "TXT"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl = "60"
  records = [incapsula_site.devops-sites[0].domain_verification]
}*/

/*resource "aws_route53_record" "cname-record" {
    count = length(incapsula_site.devops-sites)

  depends_on = [incapsula_site.devops-sites]
  allow_overwrite = true
  name = incapsula_site.devops-sites[count.index].domain
  type = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl = "60"
  records = [incapsula_site.devops-sites[count.index].dns_cname_record_value]
}
*/
output "CNAME" {
  //value       = aws_route53_record.cname-record.*.records
  value       = incapsula_site.devops-sites.*.id
}