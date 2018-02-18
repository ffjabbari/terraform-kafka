provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "zookeeper" {
  source = "./modules/zookeeper"
  ami = "${lookup(var.amis, var.aws_region)}"
  instance_type = "t2.micro"
  aws_key_name = "${var.aws_key_name}"
  aws_private_key = "${file(var.aws_key_file)}"
  ssh_username = "ubuntu"
  security_group_id ="${aws_security_group.kafka_sg.id}"
  subnet_id ="${aws_subnet.kafka_public.id}"
  ip_prefix = "10.0.1.2"
  zookeeper_version = "3.4.10"
  instance_count=5
}

