# Usage: makepkg [...]

function beko_config() {
  ./configure --prefix=${HOME}/local/`uname -s`-`uname -m` $@
}

function makepkg() {
  local current_dir=`pwd`

  shopt -u extglob
  source ${current_dir}/BEKOBUILD
  shopt -s extglob

  local tmp_dir=`mktemp -d`
  local source_dir=${tmp_dir}/source
  local package_dir=${tmp_dir}/package

  pushd ${tmp_dir}

  # create source dir
  mkdir -p "${source_dir}"
  chmod a-s "${source_dir}"

  cd ${source_dir}

  # download
  for url in $source; do
    wget -c $url
    [[ "$url" =~ .*\/(.+)$ ]]
    filename=${BASH_REMATCH[1]}
    tar xvf ${filename}
  done

  echo '==> Building...'
  cd ${current_dir} && build

  echo '==> Checking...'
  cd ${current_dir} && check

  echo '==> Packaging...'
  cd ${current_dir} && package

  popd

  rm -rf ${tmp_dir}
}

makepkg $@

