#!/bin/bash

function usage_exit() {
  exit 1
}

function install_bekobrew() {
  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
  pushd $tmpdir

  wget --no-check-certificate -O archive.tar.gz https://github.com/u-aizu/bekobrew/archive/0.0.31.tar.gz
  tar xvf ./archive.tar.gz

  local optdir=bekobrew-0.0.31

  mkdir -p ${HOME}/local/opt || true
  cp -r ${optdir}/ ${HOME}/local/opt/

  rm -f ${HOME}/local/opt/bekobrew || true
  ln -s ${HOME}/local/opt/${optdir} ${HOME}/local/opt/bekobrew

  local bekobrew_path='export PATH=${HOME}/local/opt/bekobrew/bin:${PATH}'
  echo ${bekobrew_path} >> ~/.bashrc
  echo 'export PATH=${HOME}/local/`uname -s`-`uname -m`/bin:${PATH}' >> ~/.bashrc
  echo 'export LD_LIBRARY_PATH=${HOME}/local/`uname -s`-`uname -m`/lib:${PATH}' >> ~/.bashrc

  popd  # tmpdir

  rm -rf $tmpdir

  echo ''
  echo 'Please restart shell.'
  echo ''
}

function install_develop_bekobrew() {
  local tmpdir=`mktemp -d /tmp/bekobrew-XXXXXX`
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

  rm -f ${HOME}/local/opt/bekobrew || true
  ln -s ${HOME}/local/opt/${optdir} ${HOME}/local/opt/bekobrew

  local bekobrew_path='export PATH=${HOME}/local/opt/bekobrew/bin:${PATH}'
  echo ${bekobrew_path} >> ~/.bashrc
  echo 'export PATH=${HOME}/local/`uname -s`-`uname -m`/bin:${PATH}' >> ~/.bashrc
  echo 'export LD_LIBRARY_PATH=${HOME}/local/`uname -s`-`uname -m`/lib:${PATH}' >> ~/.bashrc

  popd # tmpdir

  rm -rf $tmpdir

  echo ''
  echo 'Please restart shell.'
  echo ''
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

