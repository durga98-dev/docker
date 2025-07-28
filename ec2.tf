resource "aws_instance" "docker-server"{
    ami = ""
    vpc_security_group_ids = [aws_security_group.docker_sg.id] 
    instance_type = local.instance_type
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
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "docker_sg"
    }
}