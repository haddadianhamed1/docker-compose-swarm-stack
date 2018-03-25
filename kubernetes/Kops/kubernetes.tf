output "cluster_name" {
  value = "test.cherinehaddadian.com"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-test-cherinehaddadian-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-test-cherinehaddadian-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-test-cherinehaddadian-com.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-test-cherinehaddadian-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-2a-test-cherinehaddadian-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-test-cherinehaddadian-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-test-cherinehaddadian-com.name}"
}

output "region" {
  value = "us-west-2"
}

output "vpc_id" {
  value = "${aws_vpc.test-cherinehaddadian-com.id}"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_autoscaling_group" "master-us-west-2a-masters-test-cherinehaddadian-com" {
  name                 = "master-us-west-2a.masters.test.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-2a-masters-test-cherinehaddadian-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-test-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "test.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2a.masters.test.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-2a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "nodes-test-cherinehaddadian-com" {
  name                 = "nodes.test.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.nodes-test-cherinehaddadian-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-test-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "test.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.test.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }
}

resource "aws_ebs_volume" "a-etcd-events-test-cherinehaddadian-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "test.cherinehaddadian.com"
    Name                 = "a.etcd-events.test.cherinehaddadian.com"
    "k8s.io/etcd/events" = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "a-etcd-main-test-cherinehaddadian-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "test.cherinehaddadian.com"
    Name                 = "a.etcd-main.test.cherinehaddadian.com"
    "k8s.io/etcd/main"   = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_iam_instance_profile" "masters-test-cherinehaddadian-com" {
  name = "masters.test.cherinehaddadian.com"
  role = "${aws_iam_role.masters-test-cherinehaddadian-com.name}"
}

resource "aws_iam_instance_profile" "nodes-test-cherinehaddadian-com" {
  name = "nodes.test.cherinehaddadian.com"
  role = "${aws_iam_role.nodes-test-cherinehaddadian-com.name}"
}

resource "aws_iam_role" "masters-test-cherinehaddadian-com" {
  name               = "masters.test.cherinehaddadian.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.test.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role" "nodes-test-cherinehaddadian-com" {
  name               = "nodes.test.cherinehaddadian.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.test.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role_policy" "masters-test-cherinehaddadian-com" {
  name   = "masters.test.cherinehaddadian.com"
  role   = "${aws_iam_role.masters-test-cherinehaddadian-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.test.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-test-cherinehaddadian-com" {
  name   = "nodes.test.cherinehaddadian.com"
  role   = "${aws_iam_role.nodes-test-cherinehaddadian-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.test.cherinehaddadian.com_policy")}"
}

resource "aws_internet_gateway" "test-cherinehaddadian-com" {
  vpc_id = "${aws_vpc.test-cherinehaddadian-com.id}"

  tags = {
    KubernetesCluster = "test.cherinehaddadian.com"
    Name              = "test.cherinehaddadian.com"
  }
}

resource "aws_key_pair" "kubernetes-test-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791" {
  key_name   = "kubernetes.test.cherinehaddadian.com-ab:5c:17:b8:e7:ce:7c:ed:fb:0a:9f:5f:2d:c8:d7:91"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.test.cherinehaddadian.com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791_public_key")}"
}

resource "aws_launch_configuration" "master-us-west-2a-masters-test-cherinehaddadian-com" {
  name_prefix                 = "master-us-west-2a.masters.test.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-test-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-test-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.masters-test-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2a.masters.test.cherinehaddadian.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nodes-test-cherinehaddadian-com" {
  name_prefix                 = "nodes.test.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-test-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-test-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.nodes-test-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.test.cherinehaddadian.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.test-cherinehaddadian-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.test-cherinehaddadian-com.id}"
}

resource "aws_route_table" "test-cherinehaddadian-com" {
  vpc_id = "${aws_vpc.test-cherinehaddadian-com.id}"

  tags = {
    KubernetesCluster = "test.cherinehaddadian.com"
    Name              = "test.cherinehaddadian.com"
  }
}

resource "aws_route_table_association" "us-west-2a-test-cherinehaddadian-com" {
  subnet_id      = "${aws_subnet.us-west-2a-test-cherinehaddadian-com.id}"
  route_table_id = "${aws_route_table.test-cherinehaddadian-com.id}"
}

resource "aws_security_group" "masters-test-cherinehaddadian-com" {
  name        = "masters.test.cherinehaddadian.com"
  vpc_id      = "${aws_vpc.test-cherinehaddadian-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster = "test.cherinehaddadian.com"
    Name              = "masters.test.cherinehaddadian.com"
  }
}

resource "aws_security_group" "nodes-test-cherinehaddadian-com" {
  name        = "nodes.test.cherinehaddadian.com"
  vpc_id      = "${aws_vpc.test-cherinehaddadian-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster = "test.cherinehaddadian.com"
    Name              = "nodes.test.cherinehaddadian.com"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-test-cherinehaddadian-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-test-cherinehaddadian-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-2a-test-cherinehaddadian-com" {
  vpc_id            = "${aws_vpc.test-cherinehaddadian-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-2a"

  tags = {
    KubernetesCluster                                 = "test.cherinehaddadian.com"
    Name                                              = "us-west-2a.test.cherinehaddadian.com"
    "kubernetes.io/cluster/test.cherinehaddadian.com" = "owned"
    "kubernetes.io/role/elb"                          = "1"
  }
}

resource "aws_vpc" "test-cherinehaddadian-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                 = "test.cherinehaddadian.com"
    Name                                              = "test.cherinehaddadian.com"
    "kubernetes.io/cluster/test.cherinehaddadian.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "test-cherinehaddadian-com" {
  domain_name         = "us-west-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster = "test.cherinehaddadian.com"
    Name              = "test.cherinehaddadian.com"
  }
}

resource "aws_vpc_dhcp_options_association" "test-cherinehaddadian-com" {
  vpc_id          = "${aws_vpc.test-cherinehaddadian-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.test-cherinehaddadian-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
