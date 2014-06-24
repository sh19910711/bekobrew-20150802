#
# Copyright 2013-2014 Hiroyuki Sano.
#
# Usage: bekobrew {subcommand} [args...]

# usage: invoke_subcommand command arg1
# サブコマンド呼び出し
function invoke_subcommand() {
  local script_path=`dirname $0`

  for file_path in `ls -1 ${script_path}/sub_command/*.bash`; do
    source ${file_path}
    local regexp="${script_path}"'/sub_command/(.*)\.bash'
    [[ "${file_path}" =~ ${regexp} ]]
    local command_name=${BASH_REMATCH[1]}
    [[ -f "${script_path}/sub_command/${command_name}.bash" ]] && eval "function __beko__${command_name}() { ${command_name}_main; }"
  done

  # invoke subcommand: e.g. __beko__makepkg
  "__beko__$@"
}

invoke_subcommand "$@"

