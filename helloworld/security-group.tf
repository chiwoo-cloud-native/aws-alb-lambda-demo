locals {
  sg_name = format("%s-sg", local.function_name)
}

resource "aws_security_group" "this" {
  name        = local.sg_name
  description = "Allow inbound traffic from ALB"
  vpc_id      = data.aws_vpc.this.id

  tags = merge(local.tags, {
    Name = local.sg_name
  })
}

resource "aws_security_group_rule" "ingress_rule" {
  security_group_id        = aws_security_group.this.id
  type                     = "ingress"
  description              = "HTTP ALB to Lambda"
  from_port                = var.lambda_port
  to_port                  = var.lambda_port
  protocol                 = "TCP"
  # ALB 보안 그룹을 source 로 참조 하면 의존성 문제로 terraform destroy 에서 삭제 되지 않는 문제가 발생 합니다.
  source_security_group_id = try(element(data.aws_alb.this.security_groups, 0), "")
  # cidr_blocks = [data.aws_subnet.pub.cidr_block]
  # cidr_blocks = [local.pub_cidr_blocks]
}

resource "aws_security_group_rule" "egress_rule" {
  security_group_id = aws_security_group.this.id
  description       = "Allows lambda to establish connections to all resources"
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
