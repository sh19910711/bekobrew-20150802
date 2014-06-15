#!/bin/bash

function usage_exit() {
  exit 1
}

function install_bekobrew() {
  local tmpdir=`mktemp -d`
  pushd $tmpdir

  wget -O archive.tar.gz https://github.com/u-aizu/bekobrew/archive/0.0.12.tar.gz
  tar xvf ./archive.tar.gz

  OPTDIR=bekobrew-0.0.12

  mkdir -p ${HOME}/local/opt || true
  cp -r ${OPTDIR}/ ${HOME}/local/opt/
  echo 'export PATH=${HOME}/local/opt/'"${OPTDIR}"'/bin:${PATH}' >> ~/.bashrc

  popd  # tmpdir

  rm -rf $tmpdir
}

function install_develop_bekobrew() {
  local tmpdir=`mktemp -d`
  pushd $tmpdir

  git clone --single-branch -b develop git://github.com/sh19910711/bekobrew.git
  cd bekobrew
  make bekobrew

  source config
  local optdir=bekobrew-${BEKOBREW_VERSION}

  mkdir -p ${optdir}/bin
  cp tmp/bekobrew ${optdir}/bin

  mkdir -p ${HOME}/local/opt || true
  cp -r ${optdir}/ ${HOME}/local/opt/
  echo 'export PATH=${HOME}/local/opt/'"${optdir}"'/bin:${PATH}' >> ~/.bashrc

  popd # tmpdir

  rm -rf $tmpdir
}

GETOPT=`getopt -q -l develop -- "$@"` ; [ $? != 0 ] && usage_exit
eval set -- "$GETOPT"

while true
do
  case $1 in
  --develop) FLAG_DEVELOP=yes ; shift
        ;;
  --)   shift ; break
        ;;
  *)    usage_exit
        ;;
  esac
done

if [[ ${FLAG_DEVELOP} ]]; then
  install_develop_bekobrew
else
  install_bekobrew
fi

