# POLICIES:
# POLICY 1 == Assume Role
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# ROLE
resource "aws_iam_role" "wordpress_server_role" {
  name               = "wordpress_server_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}

# POLICY 2 == PERMISSIONS TO ACCESS DATABASE
data "aws_iam_policy_document" "Access_WordPress_Database" {
  statement {
    sid = "secretDBWordpressAccess"
    actions = [
              "secretsmanager:GetSecretValue"
    ]
    resources = [
      data.aws_secretsmanager_secret.WordPress_DB_secrets.arn
    ]
  }
}

# POLICY 3 == ACCESS WORDPRESS DATABASE

data "aws_secretsmanager_secret" "WordPress_DB_secrets" {
  name = "database-credentials"
}

# ATTACH ALL POLICIES TO THE ROLE
resource "aws_iam_role_policy_attachment" "list_instances_atch" {
  role       = aws_iam_role.wordpress_server_role.name
  policy_arn = aws_iam_policy.list_subnets_instances.arn
}
# CREATE AN INSTANCE PROFILE FROM THE ROLE
resource "aws_iam_instance_profile" "dashboard_server_profile" {
  name = "WordPress_server_profile"
  role = aws_iam_role.wordpress_server_role.name
}
