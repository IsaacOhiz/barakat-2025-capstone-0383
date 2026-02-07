resource "aws_iam_user" "dev_user" {
  name = "bedrock-dev-view"
}

resource "aws_iam_user_policy_attachment" "console_ro" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "dev_keys" {
  user = aws_iam_user.dev_user.name
}
resource "aws_iam_user_policy" "dev_s3_upload" {
  name = "BedrockS3Upload"
  user = aws_iam_user.dev_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::bedrock-assets-${var.student_id}/*"
      }
    ]
  })
}