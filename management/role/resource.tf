resource "aws_iam_policy" "ec2-describe-instances" {
  description = "EC2 Describe Instances Policy for namespace ${var.namespace}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ec2:DescribeInstances",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "cluster" {
  description = "Add Cluster Node required permissions for namespace ${var.namespace}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "cluster" {
  name_prefix = "ClusterNode-${var.namespace}-"
  role        = "${aws_iam_role.cluster.name}"
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = "${aws_iam_role.cluster.name}"
  policy_arn = "${aws_iam_policy.ec2-describe-instances.arn}"
}
