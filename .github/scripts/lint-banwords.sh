#!/bin/bash
set -euo pipefail

# summary: lint ban word is not included in the specified file.
# usage:
# 1. place line delimited definition file .github/ban-words.txt
# 2. call lint-banwords.sh with arguments, see usage --help.

function usage() {
    cat <<EOF
$(basename ${0}) is a tool for detect ban-words in the file.

Usage:
    $(basename ${0}) [<Arguments>] [<Options>]

Arguments:
    --directory       target directory to search files.
    --file-filter     regular expression to select target file.

Options:
    --definition      line-delimited ban-words definition file. (default: .github/ban-words.txt)
    --fixed-word      treat banned-word as fixed word. default is regular expression. (0|1, default: 0)
    --debug           show debug message. (0|1, default: 0)
    --help, -h        print this

Examples:
    # search ".github/workflows" directory for file name matches "k8s.*yml" pattern. detect ban words written in default path, ".github/ban-words.txt".
    $(basename ${0}) --directory .github/workflows --file-filter "k8s.*yml"

    # use detect ban words definition from ".github/ban-words2.txt".
    $(basename ${0}) --directory .github/workflows --file-filter "k8s.*yml" --definition .github/ban-words2.txt

    # enable --fixed-word to treat ban words as fixed word, not regular expression.
    $(basename ${0}) --directory .github/workflows --file-filter "k8s.*yml" --fixed-word 1

    # show debug message.
    $(basename ${0}) --directory .github/workflows --file-filter "k8s.*yml" --debug 1
EOF
}

while [ $# -gt 0 ]; do
    case $1 in
        # target directory
        --directory) DIRECTORY=$2; shift 2; ;;
        # regex target file filter
        --file-filter) FILTER=$2; shift 2; ;;
        # ban-words definition file
        --definition) DEFINITION=$2; shift 2; ;;
        # treat ban-words as fixed word, not regular expression.
        --fixed-word) BAN_WORD_FIXED=$2; shift 2; ;;
        # show debug message
        --debug) DEBUG=$2; shift 2; ;;
        --help) usage; exit 1; ;;
        -h) usage; exit 1; ;;
        *) shift ;;
    esac
done

# summary: guard arguments.
# return int 1 on error
function app:guard_arguments() {

  DEBUG=$5
  if [[ "$5" != "0" ]]; then
    DEBUG=true
  fi

  console::write_debug "convert argument --directory '$1' from relative path to absolute path."
  DIRECTORY=$1
  if [[ "$1" == "" ]]; then
    console::write_error "--directory is missing or empty."
    errorcode=1
  else
    DIRECTORY=$(readlink -e $1)
    if [[ "${DIRECTORY}" == "" ]]; then
      console::write_error "--directory '$1', directory not found."
      errorcode=1
    fi
  fi

  FILTER=$2
  if [[ "$2" == "" ]]; then
    console::write_error "--file-filter is missing or empty."
    errorcode=1
  fi

  console::write_debug "checking argument --definition '$3' is exists or not."
  DEFINITION=$3
  if [[ "$(readlink -e ${DEFINITION})" == "" ]]; then
    console::write_error "--definition '$3', file not found."
    errorcode=1
  fi

  BAN_WORD_FIXED=$4
  if [[ "$4" != "0" ]]; then
    console::write_debug "--fixed-word is enabled. banned words will not handle as regular expression."
    BAN_WORD_FIXED=true
  fi

  return $errorcode
}
# summary: output error message with color.
# return void
function console::write_error() {
  local message=$1
  echo -e "${RED}${message}${NORMAL}"
}
# summary: output success message with color.
# return void
function console::write_success() {
  local message=$1
  echo -e "${GREEN}${message}${NORMAL}"
}
# summary: output debug message with color.
# return void
function console::write_debug() {
  if [[ "$DEBUG" == "true" ]]; then
    local message=$1
    echo -e "${YELLOW}${message}${NORMAL}"
  fi
}
# summary: output message with extra spaces on each line.
# return void
function console::write_add_space() {
  local message=$1
  local spaces=$2
  echo -e "$message" | sed -e "s/^/$spaces/g"
}
# summary: load colour code for terminal output.
# return void
function console::load_colorcode() {
  if export | grep "GITHUB_ACTIONS" > /dev/null; then
    RED=""
    GREEN=""
    YELLOW=""
    NORMAL=""
  else
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    NORMAL=$(tput sgr0)
  fi
}
# summary: cat file without comment lines.
# return array::string
function file::readline_wo_comment() {
  local file=$1
  cat "$file" | egrep -v "(^#.*|^$)"
}
# summary: check banned word (regular expression) is included in the file specified.
# retern void
function ban::check_word() {
  local file=$1
  local word=$2
  local fixed=$3
  local ban_exists=0
  if [[ "${fixed}" == "true" ]]; then
    # search fixed word
    output=$(file::readline_wo_comment "${file}" | grep -Fn "${word}") || ban_exists=$?
  else
    # search regular expression
    output=$(file::readline_wo_comment "${file}" | egrep -n "${word}") || ban_exists=$?
  fi
  if [[ "${ban_exists}" == "0" ]]; then
    errorcode=1
    console::write_error "X: banned word '${word}' found (${file})"
    console::write_add_space "${output}" "   "
  fi
}

# init
errorcode=0
console::load_colorcode

# main
if app:guard_arguments "${DIRECTORY:-""}" "${FILTER:-""}" "${DEFINITION:-".github/ban-words.txt"}" "${BAN_WORD_FIXED:-0}" "${DEBUG:-0}"; then
  console::write_debug "reading definition file from '${DEFINITION}'"
  definitions=$(file::readline_wo_comment "${DEFINITION}")

  console::write_debug "search target files from directory '${DIRECTORY}', filter expression '${FILTER}'"
  targetfiles=$(ls "${DIRECTORY}" | egrep "${FILTER}") || files_missing=$?

  # guard
  if [[ "${files_missing:-0}" != 0 ]]; then
    console::write_error "target files not found from '${DIRECTORY}'."
    errorcode=1
  fi

  # search ban words
  for file in ${targetfiles}; do
    console::write_debug "  * checking file '${file}'"
    for word in ${definitions}; do
      console::write_debug "    * banned word '${word}',file '${file}'"
      ban::check_word "${DIRECTORY}/${file}" "${word}" "${BAN_WORD_FIXED}"
    done
  done
fi

# suuccess result
if [[ "${errorcode}" == "0" ]]; then
  console::write_success "RESULT: conglaturations!! ban words not found from files in '${DIRECTORY}'\n${targetfiles:-""}"
fi

exit $errorcode
