resource "aws_instance" "docker-server"{
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.docker_sg.id] 
    instance_type = local.instance_type
    # 20GB is not enough
  root_block_device {
    volume_size = 50  # Set root volume size to 50GB
    volume_type = "gp3"  # Use gp3 for better performance (optional)
    # encrypted = true
    # kms_key_id = "arn:aws:kms:us-east-1:851725313390:key/67301480-db14-4464-8b46-0faf5b4fc60e"
  }
  user_data = file("docker-installation.sh")
  tags = {
    Name    = "docker"
  }
}


resource "aws_security_group" "docker_sg" {
    name = "Docker_sg"
    description = "All inbound and outbound traffic"
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "docker_sg"
    }
}