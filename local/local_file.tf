resource "local_file" "localfile" {
    filename = "/tmp/localfile.txt"
    content = "Test content, Terraform!"
}