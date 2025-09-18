# Buscar a última AMI Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

# Criar uma instância EC2
resource "aws_instance" "exemplo_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "Infraascode.com.br - Terraform"
  }
}
