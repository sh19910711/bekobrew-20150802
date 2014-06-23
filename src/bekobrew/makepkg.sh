# Usage: makepkg [...]

function beko_config() {
  ./configure --prefix=${HOME}/local/`uname -s`-`uname -m` $@
}

function is_function() {
  [ `type -t $1` == 'function' ]
}

function makepkg() {
  local current_dir=`pwd`

  shopt -u extglob
  source ${current_dir}/BEKOBUILD
  shopt -s extglob

  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  local source_dir=${tmpdir}/source
  local package_dir=${tmpdir}/package

  pushd ${tmpdir}

  # create source dir
  mkdir -p "${source_dir}"
  chmod a-s "${source_dir}"

  cd ${source_dir}

  # download
  for url in $source; do
    wget --no-check-certificate -c $url
    [[ "$url" =~ .*\/(.+)$ ]]
    filename=${BASH_REMATCH[1]}
    tar xvf ${filename}
  done

  echo '==> Preparing...'
  is_function prepare && cd ${current_dir} && prepare

  echo '==> Building...'
  cd ${current_dir} && build

  echo '==> Checking...'
  is_function check && cd ${current_dir} && check

  echo '==> Packaging...'
  cd ${current_dir} && package

  popd

  rm -rf ${tmpdir}
}

makepkg $@

