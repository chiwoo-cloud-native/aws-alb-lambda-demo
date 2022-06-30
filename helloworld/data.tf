data "aws_region" "current" {}

data "aws_route53_zone" "public" {
  name = var.domain
}

data "aws_acm_certificate" "this" {
  domain = var.domain
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [format("%s-vpc", local.name_prefix)]
  }
}

data "aws_subnets" "hello" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  filter {
    name   = "tag:Name"
    values = [ format("%s-hello*", local.name_prefix) ]
  }
}

# ALB
data "aws_alb" "this" {
  name = format("%s-pub-alb", local.name_prefix)
}

data "aws_alb_listener" "pub_https" {
  load_balancer_arn = data.aws_alb.this.arn
  port              = 443
}

data "aws_security_group" "alb_sg" {
  name = format("%s-pub-alb-sg", local.name_prefix)
}
