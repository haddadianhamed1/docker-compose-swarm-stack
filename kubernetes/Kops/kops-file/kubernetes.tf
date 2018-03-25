output "cluster_name" {
  value = "testha.cherinehaddadian.com"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-testha-cherinehaddadian-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-testha-cherinehaddadian-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-testha-cherinehaddadian-com.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-testha-cherinehaddadian-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2b-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2c-testha-cherinehaddadian-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-testha-cherinehaddadian-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-testha-cherinehaddadian-com.name}"
}

output "region" {
  value = "us-west-2"
}

output "vpc_id" {
  value = "${aws_vpc.testha-cherinehaddadian-com.id}"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_autoscaling_group" "master-us-west-2a-masters-testha-cherinehaddadian-com" {
  name                 = "master-us-west-2a.masters.testha.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-2a-masters-testha-cherinehaddadian-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-2a.masters.testha.cherinehaddadian.com"
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

resource "aws_autoscaling_group" "nginx-hamed-testha-cherinehaddadian-com" {
  name                 = "nginx-hamed.testha.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.nginx-hamed-testha-cherinehaddadian-com.id}"
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2b-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2c-testha-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nginx-hamed.testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = "nginx"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/hamed"
    value               = "hello"
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

resource "aws_autoscaling_group" "nginx-testha-cherinehaddadian-com" {
  name                 = "nginx.testha.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.nginx-testha-cherinehaddadian-com.id}"
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2b-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2c-testha-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nginx.testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = "nginx"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/hamed"
    value               = "hello"
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

resource "aws_autoscaling_group" "nodes-testha-cherinehaddadian-com" {
  name                 = "nodes.testha.cherinehaddadian.com"
  launch_configuration = "${aws_launch_configuration.nodes-testha-cherinehaddadian-com.id}"
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2b-testha-cherinehaddadian-com.id}", "${aws_subnet.us-west-2c-testha-cherinehaddadian-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.testha.cherinehaddadian.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/enabled:"
    value               = "infra"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/hamed"
    value               = "hello"
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

resource "aws_ebs_volume" "a-etcd-events-testha-cherinehaddadian-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "testha.cherinehaddadian.com"
    Name                 = "a.etcd-events.testha.cherinehaddadian.com"
    "k8s.io/etcd/events" = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_ebs_volume" "a-etcd-main-testha-cherinehaddadian-com" {
  availability_zone = "us-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster    = "testha.cherinehaddadian.com"
    Name                 = "a.etcd-main.testha.cherinehaddadian.com"
    "k8s.io/etcd/main"   = "a/a"
    "k8s.io/role/master" = "1"
  }
}

resource "aws_iam_instance_profile" "masters-testha-cherinehaddadian-com" {
  name = "masters.testha.cherinehaddadian.com"
  role = "${aws_iam_role.masters-testha-cherinehaddadian-com.name}"
}

resource "aws_iam_instance_profile" "nodes-testha-cherinehaddadian-com" {
  name = "nodes.testha.cherinehaddadian.com"
  role = "${aws_iam_role.nodes-testha-cherinehaddadian-com.name}"
}

resource "aws_iam_role" "masters-testha-cherinehaddadian-com" {
  name               = "masters.testha.cherinehaddadian.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.testha.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role" "nodes-testha-cherinehaddadian-com" {
  name               = "nodes.testha.cherinehaddadian.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.testha.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role_policy" "masters-testha-cherinehaddadian-com" {
  name   = "masters.testha.cherinehaddadian.com"
  role   = "${aws_iam_role.masters-testha-cherinehaddadian-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.testha.cherinehaddadian.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-testha-cherinehaddadian-com" {
  name   = "nodes.testha.cherinehaddadian.com"
  role   = "${aws_iam_role.nodes-testha-cherinehaddadian-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.testha.cherinehaddadian.com_policy")}"
}

resource "aws_internet_gateway" "testha-cherinehaddadian-com" {
  vpc_id = "${aws_vpc.testha-cherinehaddadian-com.id}"

  tags = {
    KubernetesCluster = "testha.cherinehaddadian.com"
    Name              = "testha.cherinehaddadian.com"
  }
}

resource "aws_key_pair" "kubernetes-testha-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791" {
  key_name   = "kubernetes.testha.cherinehaddadian.com-ab:5c:17:b8:e7:ce:7c:ed:fb:0a:9f:5f:2d:c8:d7:91"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.testha.cherinehaddadian.com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791_public_key")}"
}

resource "aws_launch_configuration" "master-us-west-2a-masters-testha-cherinehaddadian-com" {
  name_prefix                 = "master-us-west-2a.masters.testha.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-testha-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-testha-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.masters-testha-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-2a.masters.testha.cherinehaddadian.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nginx-hamed-testha-cherinehaddadian-com" {
  name_prefix                 = "nginx-hamed.testha.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-testha-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-testha-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.nodes-testha-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nginx-hamed.testha.cherinehaddadian.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nginx-testha-cherinehaddadian-com" {
  name_prefix                 = "nginx.testha.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-testha-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-testha-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.nodes-testha-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nginx.testha.cherinehaddadian.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "nodes-testha-cherinehaddadian-com" {
  name_prefix                 = "nodes.testha.cherinehaddadian.com-"
  image_id                    = "ami-485eef30"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-testha-cherinehaddadian-com-ab5c17b8e7ce7cedfb0a9f5f2dc8d791.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-testha-cherinehaddadian-com.id}"
  security_groups             = ["${aws_security_group.nodes-testha-cherinehaddadian-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.testha.cherinehaddadian.com_user_data")}"

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
  route_table_id         = "${aws_route_table.testha-cherinehaddadian-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.testha-cherinehaddadian-com.id}"
}

resource "aws_route_table" "testha-cherinehaddadian-com" {
  vpc_id = "${aws_vpc.testha-cherinehaddadian-com.id}"

  tags = {
    KubernetesCluster = "testha.cherinehaddadian.com"
    Name              = "testha.cherinehaddadian.com"
  }
}

resource "aws_route_table_association" "us-west-2a-testha-cherinehaddadian-com" {
  subnet_id      = "${aws_subnet.us-west-2a-testha-cherinehaddadian-com.id}"
  route_table_id = "${aws_route_table.testha-cherinehaddadian-com.id}"
}

resource "aws_route_table_association" "us-west-2b-testha-cherinehaddadian-com" {
  subnet_id      = "${aws_subnet.us-west-2b-testha-cherinehaddadian-com.id}"
  route_table_id = "${aws_route_table.testha-cherinehaddadian-com.id}"
}

resource "aws_route_table_association" "us-west-2c-testha-cherinehaddadian-com" {
  subnet_id      = "${aws_subnet.us-west-2c-testha-cherinehaddadian-com.id}"
  route_table_id = "${aws_route_table.testha-cherinehaddadian-com.id}"
}

resource "aws_security_group" "masters-testha-cherinehaddadian-com" {
  name        = "masters.testha.cherinehaddadian.com"
  vpc_id      = "${aws_vpc.testha-cherinehaddadian-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster = "testha.cherinehaddadian.com"
    Name              = "masters.testha.cherinehaddadian.com"
  }
}

resource "aws_security_group" "nodes-testha-cherinehaddadian-com" {
  name        = "nodes.testha.cherinehaddadian.com"
  vpc_id      = "${aws_vpc.testha-cherinehaddadian-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster = "testha.cherinehaddadian.com"
    Name              = "nodes.testha.cherinehaddadian.com"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  source_security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-testha-cherinehaddadian-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-testha-cherinehaddadian-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-2a-testha-cherinehaddadian-com" {
  vpc_id            = "${aws_vpc.testha-cherinehaddadian-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-2a"

  tags = {
    KubernetesCluster                                   = "testha.cherinehaddadian.com"
    Name                                                = "us-west-2a.testha.cherinehaddadian.com"
    "kubernetes.io/cluster/testha.cherinehaddadian.com" = "owned"
    "kubernetes.io/role/elb"                            = "1"
  }
}

resource "aws_subnet" "us-west-2b-testha-cherinehaddadian-com" {
  vpc_id            = "${aws_vpc.testha-cherinehaddadian-com.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-west-2b"

  tags = {
    KubernetesCluster                                   = "testha.cherinehaddadian.com"
    Name                                                = "us-west-2b.testha.cherinehaddadian.com"
    "kubernetes.io/cluster/testha.cherinehaddadian.com" = "owned"
    "kubernetes.io/role/elb"                            = "1"
  }
}

resource "aws_subnet" "us-west-2c-testha-cherinehaddadian-com" {
  vpc_id            = "${aws_vpc.testha-cherinehaddadian-com.id}"
  cidr_block        = "172.20.96.0/19"
  availability_zone = "us-west-2c"

  tags = {
    KubernetesCluster                                   = "testha.cherinehaddadian.com"
    Name                                                = "us-west-2c.testha.cherinehaddadian.com"
    "kubernetes.io/cluster/testha.cherinehaddadian.com" = "owned"
    "kubernetes.io/role/elb"                            = "1"
  }
}

resource "aws_vpc" "testha-cherinehaddadian-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                   = "testha.cherinehaddadian.com"
    Name                                                = "testha.cherinehaddadian.com"
    "kubernetes.io/cluster/testha.cherinehaddadian.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "testha-cherinehaddadian-com" {
  domain_name         = "us-west-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster = "testha.cherinehaddadian.com"
    Name              = "testha.cherinehaddadian.com"
  }
}

resource "aws_vpc_dhcp_options_association" "testha-cherinehaddadian-com" {
  vpc_id          = "${aws_vpc.testha-cherinehaddadian-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.testha-cherinehaddadian-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
