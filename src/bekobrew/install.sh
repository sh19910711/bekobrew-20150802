# Usage: bekobrew install {package-name}
# e.g. bekobrew install hello

function install_package() {
  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  pushd ${tmpdir}
  bekobrew get $1
  cd $1
  source BEKOBUILD
  bekobrew makepkg
  popd
}

install_package $@

