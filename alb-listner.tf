# Create ALB Listner - HTTPS

resource "aws_lb_listener" "dfsc_https" {
  load_balancer_arn = aws_lb.dfsc_alb.arn
  port = 443 
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-0-2015-04"
  certificate_arn = "arn:aws:acm:us-east-1:015148330366:certificate/17eacedc-d24c-4ad1-af0d-7eca4a46c301"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.dfsc-front-end-tg.arn
  }
}

# Create ALB Listner Backend Rule - HTTPS

resource "aws_lb_listener_rule" "dfsc_admin_https" {
  listener_arn = aws_lb_listener.dfsc_https.arn 
  priority = 100
  action {
      type = "forward"
      target_group_arn = aws_lb_target_group.dfsc-back-end-tg.arn
  }
  condition {
      path_pattern {
          values = ["/admin*"]
      }
  }
}