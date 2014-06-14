# Usage: makepkg [...]

current_dir=`pwd`

shopt -u extglob
source ${current_dir}/BEKOBUILD
shopt -s extglob

tmp_dir=`mktemp -d`
source_dir=${tmp_dir}/source
package_dir=${tmp_dir}/package

pushd ${tmp_dir}

# name-1.2-1.tar.bz2
archive_file=${package_name}-${package_version}-${package_release}.tar.bz2

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

# packaging
cd ${current_dir} && build
cd ${current_dir} && package
cd ${package_dir} && tar zcvf ../${archive_file} *
cd ${current_dir}

popd

cp ${tmp_dir}/${archive_file} ${current_dir}/
rm -rf ${tmp_dir}
