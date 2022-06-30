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

# Subnets
data "aws_subnets" "pub" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  filter {
    name   = "tag:Name"
    values = [ format("%s-pub*", local.name_prefix) ]
  }
}

data "aws_subnet" "pub" {
  for_each = toset(data.aws_subnets.pub.ids)
  id       = each.value
}

locals {
  pub_cidr_blocks = [for s in data.aws_subnet.pub : s.cidr_block]
}

output "pub_cidr_blocks" {
  value = local.pub_cidr_blocks
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
