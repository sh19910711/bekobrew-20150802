# Usage: bekobrew install {package-name}
# e.g. bekobrew install hello

function install_package() {
  local tmpdir=`mktemp -d`
  pushd ${tmpdir}
  bekobrew get $1
  cd $1
  source BEKOBUILD
  bekobrew makepkg
  bekobrew deploy ${package_name}-${package_version}-${package_release}.tar.bz2
  popd
}

install_package $@

