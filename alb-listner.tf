# Create ALB Listner - HTTPS

resource "aws_lb_listener" "dfsc_https" {
  load_balancer_arn = aws_lb.dfsc_alb.arn
  port = 443 
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS-1-0-2015-04"
  certificate_arn = "arn:aws:acm:eu-west-1:015148330366:certificate/0a732702-57a4-4adf-8f08-49942107147b"
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