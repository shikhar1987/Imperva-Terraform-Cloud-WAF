provider "incapsula" {
  api_id  = "xxxx"
  api_key = "xxxx"
}
provider "aws" {
  region = "ap-southeast-2"
  access_key = "xxxx"
  secret_key = "xxxx"
}
data "aws_route53_zone" "zone" {
  name = "securitytestingsolutions.com."
}

resource "incapsula_site" "devops6-site" {
  domain                 = "devops6.imperva.securitytestingsolutions.com"
  account_id             = "1544595"
  ref_id                 = "123456"
  force_ssl              = "false"
  data_storage_region    = "AU"
}
resource "aws_route53_record" "devops6-record" {
  depends_on = [incapsula_site.devops6-site]
  name = "devops6.imperva.${data.aws_route53_zone.zone.name}"
  type = "CNAME"
  zone_id = data.aws_route53_zone.zone.zone_id
  ttl = "60"
  records = [incapsula_site.devops6-site.dns_cname_record_value]
}

