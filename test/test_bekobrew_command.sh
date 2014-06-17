#!/bin/bash

source test/common

oneTimeSetUp() {
  make bekobrew
}

test_no_parameter() {
  bekobrew >/dev/null 2>&1
  local ret=$?
  assertNotEquals 'it should return error code' ${SHUNIT_TRUE} ${ret}
}

test_hello() {
  bekobrew hello >/dev/null 2>&1
  local ret=$?
  assertEquals 'it should return 0' ${SHUNIT_TRUE} ${ret}
}

test_makepkg_bekobuild_notfound() {
  pushd `mktemp -d`
  bekobrew makepkg >/dev/null 2>&1
  local ret=$?
  assertNotEquals ${SHUNIT_TRUE} ${ret}
  popd
}

test_makepkg_bekobuild_build_notfound() {
  pushd `mktemp -d`
  touch BEKOBUILD
  bekobrew makepkg >/dev/null 2>&1
  local ret=$?
  assertNotEquals ${SHUNIT_TRUE} ${ret}
  popd
}

source test/lib/shunit2-2.1.6/src/shunit2

