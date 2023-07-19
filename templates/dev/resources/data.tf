data "aws_availability_zones" "available" {}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

data "aws_route_tables" "accepter" {
  provider = aws.accepter
  vpc_id = module.vpc_opensearch.vpc_id
}

data "aws_route_tables" "requester" {
  provider = aws.requester
  vpc_id = module.vpc_apps.vpc_id
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "mycompany1" {
  name         = "app.internal.mycompany"
  private_zone = true
}

data "aws_route53_zone" "mycompany2" {
  name         = "app.mycompany.com"
  private_zone = true
}

data "aws_iam_policy_document" "fluentbit_opensearch_access" {
  # Identity Based Policy specifies a list of IAM permissions
  # that principal has against OpenSearch service API
  # ref: https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ac.html#ac-types-identity
  statement {
    sid       = "OpenSearchAccess"
    effect    = "Allow"
    resources = ["${aws_elasticsearch_domain.opensearch.arn}/*"]
    actions   = ["es:ESHttp*"]
  }
}

data "aws_iam_policy_document" "opensearch_access_policy" {
  # This is the resource-based policy that allows to set access permissions on OpenSearch level
  # To be working properly the client must support IAM (SDK, fluent-bit with sigv4, etc.) Browsers don't do IAM.
  # ref: https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ac.html#ac-types-resource
  statement {
    sid       = "WriteDomainLevelAccessToOpenSearch"
    effect    = "Allow"
    resources = ["${aws_elasticsearch_domain.opensearch.arn}/*"] # this can be an index prefix like '/foo-*'
    actions = [                                                  #ref: https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ac.html#ac-reference
      "es:ESHttpPost",
      "es:ESHttpPut"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.name}-aws-for-fluent-bit-sa-irsa"]
    }
  }

  statement {
    sid    = "AdminDomainLevelAccessToOpenSearch"
    effect = "Allow"
    resources = [
      aws_elasticsearch_domain.opensearch.arn,
      "${aws_elasticsearch_domain.opensearch.arn}/*",
    ]
    actions = ["es:*"]
    principals {
      type        = "*"
      identifiers = ["*"] # must be set to wildcard when clients can't sign sigv4 or pass IAM to OpenSearch (aka browsers)
    }
  }
}

data "aws_secretsmanager_secret" "github-authtoken" {
  arn = "arn:aws:secretsmanager:eu-central-1:686175358231:secret:github/oauthtoken-SvEEBw"
}

data "aws_secretsmanager_secret_version" "github-authtoken-version" {
  secret_id = data.aws_secretsmanager_secret.github-authtoken.id
}