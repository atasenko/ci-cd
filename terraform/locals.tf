locals {
  ssh-key = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
}
