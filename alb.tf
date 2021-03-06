# Create Application Load Balancer Security Group

resource "aws_security_group" "dfsc_alb_sg" {
    name = "ALB Security Group"
    vpc_id = aws_vpc.dfsc_vpc.id 
    egress  {
        cidr_blocks = ["0.0.0.0/0" ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    } 
    ingress  {
        cidr_blocks = [ "0.0.0.0/0" ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    } 
    tags = {
        Name = "DFSC ALB Security Group"
        Terraform = "True"
    }
}

# Crate Application Load Balancer

resource "aws_lb" "dfsc_alb" {
    name = "dfsc-app-laod-balancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [ "aws_security_group.dfsc_alb_sg.id" ]
    subnets = [ 
        aws_subnet.dfsc-public-1a.id,
        aws_subnet.dfsc-public-1b.id
    ]
    enable_deletion_protection = false
    tags = {
        Name = "DFSC Application Load Balancer"
        Terraform = "True"
    }
}











