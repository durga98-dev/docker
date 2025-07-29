resource "aws_instance" "docker-server"{
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = [aws_security_group.docker_sg.id] 
    instance_type = local.instance_type
    root_block_device {
        volume_size = 50
        volume_type = "gp3"
  }
  user_data = file("docker-installation.sh")
    tags = {
        Name = "Docker-demo"
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