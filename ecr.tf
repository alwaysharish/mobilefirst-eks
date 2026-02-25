
resource "aws_ecr_repository" "this" {
  count                = length(var.ecr_names)
  name                 = var.ecr_names[count.index]
  image_tag_mutability = var.image_mutability # or "IMMUTABLE" based on your requirement
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}

data "aws_iam_policy_document" "ecr" {
  statement {
    sid    = "new policy"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "this" {
  count      = length(var.ecr_names)
  repository = aws_ecr_repository.this[count.index].name
  policy     = data.aws_iam_policy_document.ecr.json
}
