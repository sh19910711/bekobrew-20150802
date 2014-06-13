current_dir=`pwd`
source_dir=${current_dir}/src
package_dir=${current_dir}/pkg

shopt -u extglob
source BKGBUILD
shopt -s extglob

rm -rf ${package_dir} || true

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
cd ${current_dir}

cd ${current_dir}

# packaging
build

cd ${current_dir}

package

