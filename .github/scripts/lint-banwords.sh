#!/bin/bash -eu

# summary: lint ban word is not included in the specified file.
# usage:
# 1. place line delimited definition file .github/ban-words.txt
# 2. call ban-word.sh with arguments, see usage.

function usage() {
    cat <<EOF
$(basename ${0}) is a tool for detect ban-words in the file.

Usage:
    $(basename ${0}) [<arguments>] [<options>]

ARGUMENTS:
    --directory       target directory to search files.
    --file-filter     regular expression to select target file.

OPTIONS:
    --definition      line-delimited ban-words definition file. (default: .github/ban-words.txt)
    --debug           show debug message. (0|1, default: 0)
    --help, -h        print this

EXAMPLES:
    # search ".github/workflows" directory for file name matches "k8s.*yml" pattern. detect ban words written in ".github/ban-words.txt"
    $(basename ${0}) --directory .github/workflows --file-filter k8s.*yml

    # search ".github/workflows" directory for file name matches "k8s.*yml" pattern. detect ban words written in ".github/ban-words2.txt"
    $(basename ${0}) --directory .github/workflows --file-filter k8s.*yml --definition .github/ban-words2.txt

    # show debug message
    $(basename ${0}) --directory .github/workflows --file-filter k8s.*yml --debug 1
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
  DIRECTORY=$1
  if [[ "$1" == "" ]]; then
    console::write_error "error argument --directory missing."
    errorcode=1
  fi

  FILTER=$2
  if [[ "$2" == "" ]]; then
    console::write_error "error argument --filter missing."
    errorcode=1
  fi

  DEFINITION=$3
  if [[ "$3" == "" ]]; then
    console::write_error "error argument --definition is empty, please specify valid value or no arguments to use default."
    errorcode=1
  fi

  DEBUG=$4
  if [[ "$4" != "0" ]]; then
    DEBUG=1
  fi

  if [[ "$errorcode" != "0" ]]; then
    console::write_error "error validating arguments. showing usage."
    usage
    return 1
  fi
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
  if [[ "$DEBUG" == "1" ]]; then
    local message=$1
    echo -e "${YELLOW}${message}${YELLOW}"
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
# summary: cat file without the comments.
# return array::string
function file::read_file() {
  local file=$1
  cat "$file" | egrep -v "(^#.*|^$)"
}
# summary: check ban word is include in the file.
# retern void
function ban::check_word() {
  local file=$1
  local word=$2
  local result=0
  output=$(cat "${file}" | grep -Fn "${word}") || result=$?
  if [[ "$result" == "0" ]]; then
    errorcode=1
    console::write_error "X: ban word '${word}' found (${file})"
    console::write_add_space "$output" "   "
  fi
}

# init
errorcode=0
console::load_colorcode

# main
if app:guard_arguments ${DIRECTORY:-""} ${FILTER:-""} ${DEFINITION:-".github/ban-words.txt"} ${DEBUG:-0}; then
  console::write_debug "reading definition file ${DEFINITION}"
  definitions=$(file::read_file "${DEFINITION}")

  console::write_debug "search target files from directory ${DIRECTORY} filter ${FILTER}"
  targetfiles=$(ls "${DIRECTORY}" | grep "$FILTER")

  # search ban words
  for file in ${targetfiles}; do
    console::write_debug "checking file ${file}"
    for word in ${definitions}; do
      ban::check_word "${DIRECTORY}/${file}" "${word}"
    done
  done
fi

# suuccess result
if [[ "$errorcode" == "0" ]]; then
  console::write_success "RESULT: conglaturations!! ban words not found from files in '${DIRECTORY}'\n${targetfiles}"
fi
exit $errorcode
