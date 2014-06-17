function deploy_package() {
  local archive_file=$1
  local local_dir=$HOME/local/`uname -s`-`uname -m`
  mkdir -p ${local_dir} || true
  tar -C ${local_dir} xvf ${archive_file}
}

deploy_package $1

