data "github_repository" "this" {
  name = var.github_repo
}

data "github_branch" "this" {
  repository = var.github_repo
  branch     = var.github_branch
}

resource "null_resource" "package" {
  triggers = {
    branch_sha = data.github_branch.this.sha
  }

  provisioner "local-exec" {
    command = <<-EOT
      rm -rf ./build/repo ./build/package
      git clone ${data.github_repository.this.ssh_clone_url} -b ${var.github_branch} --depth 1 ./build/repo
      docker build \
        -f ./build/Dockerfile \
        --target artifact \
        --platform linux/amd64 \
        --output type=local,dest=./build/package \
        --build-arg python_version=${var.python_version} \
        build
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ./build/repo ./build/package"
  }
}

resource "archive_file" "package" {
  type        = "zip"
  source_dir  = "${path.module}/build/package"
  output_path = "${path.module}/build/package.zip"
  depends_on  = [null_resource.package]

  provisioner "local-exec" {
    when    = destroy
    command = "rm ./build/package.zip"
  }

  lifecycle {
    replace_triggered_by = [null_resource.package]
  }
}
