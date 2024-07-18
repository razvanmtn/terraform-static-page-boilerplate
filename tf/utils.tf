resource "null_resource" "pause" {
  provisioner "local-exec" {
    command = "sleep 10"
  }

  depends_on = [aws_s3_bucket.bucket]
}
