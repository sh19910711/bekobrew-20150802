#!/bin/bash

function usage_exit() {
  exit 1
}

function install_bekobrew() {
  local tmpdir=`mktemp -d`
  pushd $tmpdir

  wget -O archive.tar.gz https://github.com/u-aizu/bekobrew/archive/0.0.22.tar.gz
  tar xvf ./archive.tar.gz

  OPTDIR=bekobrew-0.0.22

  mkdir -p ${HOME}/local/opt || true
  cp -r ${OPTDIR}/ ${HOME}/local/opt/
  echo 'export PATH=${HOME}/local/opt/'"${OPTDIR}"'/bin:${PATH}' >> ~/.bashrc
  echo 'export PATH=${HOME}/local/`uname -s`-`uname -m`/bin:${PATH}' >> ~/.bashrc

  echo 'Run below command:'
  echo 'export PATH=${HOME}/local/opt/'"${optdir}"'/bin:${PATH}'

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

  rm -rf ${optdir} || true
  mkdir -p ${optdir}/bin
  cp tmp/bekobrew ${optdir}/bin

  mkdir -p ${HOME}/local/opt || true
  cp -r ${optdir}/ ${HOME}/local/opt/
  echo 'export PATH=${HOME}/local/opt/'"${optdir}"'/bin:${PATH}' >> ~/.bashrc
  echo 'export PATH=${HOME}/local/`uname -s`-`uname -m`/bin:${PATH}' >> ~/.bashrc

  echo 'Run below command:'
  echo 'export PATH=${HOME}/local/opt/'"${optdir}"'/bin:${PATH}'

  popd # tmpdir

  rm -rf $tmpdir
}

ARGS=$@
eval set -- "$ARGS"

while true
do
  case $1 in
  --develop) FLAG_DEVELOP=1 ; shift
        ;;
  --)   shift ; break
        ;;
  *)    break
        ;;
  esac
done

if [ "${FLAG_DEVELOP}" == "1" ]; then
  install_develop_bekobrew
else
  install_bekobrew
fi

