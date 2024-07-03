terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2instance" {
  ami           = "ami-0eaf7c3456e7b5b68"
  instance_type = "t2.micro"
  subnet_id     = var.subnet
  vpc_security_group_ids = [ "sg-00051fdcfc68bb628" ]
  key_name = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    set -e
    amazon-linux-extras install docker
    service docker start
    usermod -a -G docker ec2-user
    chkconfig docker on
    yum install -y git
    curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
      -o /usr/local/bin/docker-compose
    mv /usr/local/bin/docker-compose /usr/bin/docker-compose
    chmod +x /usr/bin/docker-compose
    docker pull jenkins/jenkins
    sleep 1m 
    docker run -d -p 8080:8080 -v jenkins_home:/var/jenkins_home jenkins/jenkins
  EOF
  tags = {
    Name = "Jenkins"
  }
}