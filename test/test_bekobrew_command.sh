#!/bin/bash

source test/common

oneTimeSetUp() {
  make bekobrew
}

test_no_parameter() {
  bekobrew >/dev/null 2>&1
  local ret=$?
  assertNotEquals 'it should return error code' $SHUNIT_TRUE $ret
}

test_hello() {
  bekobrew hello >/dev/null 2>&1
  local ret=$?
  assertEquals 'it should return 0' ${SHUNIT_TRUE} $ret
}


source test/lib/shunit2-2.1.6/src/shunit2

