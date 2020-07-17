#!/bin/bash -eu
while [ $# -gt 0 ]; do
    case $1 in
        # target directory
        --directory) DIRECTORY=$2; shift 2; ;;
        # regex target file filter
        --file-filter) FILTER=$2; shift 2; ;;
        # ban-words definition file
        --definition) DEFINITION=$2; shift 2; ;;
        *) shift ;;
    esac
done

# summary: output error message with color.
# return void
function console::write_error() {
  message=$1
  echo -e "${RED}${message}${NORMAL}"
}
# summary: output success message with color.
# return void
function console::write_success() {
  message=$1
  echo -e "${GREEN}${message}${NORMAL}"
}
# summary: output message with extra spaces on each line.
# return void
function console::write_add_space() {
  message=$1
  spaces=$2
  echo -e "$message" | sed -e "s/^/$spaces/g"
}

# summary: load colour code for terminal output.
# return void
function console::load_colorcode() {
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  NORMAL=$(tput sgr0)
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
  output=$(file::read_file "${file}" | grep -Fn "${word}") || result=$?
  if [[ "$result" == "0" ]];
  then
    errorcode=1
    console::write_error "X: ban word '${word}' found (${file})"
    console::write_add_space "$output" "   "
  fi
}

# initialize
errorcode=0
console::load_colorcode
definitions=$(file::read_file "${DEFINITION}")
targetfiles=$(ls "${DIRECTORY}" | grep "$FILTER")

# main
for file in ${targetfiles};
do
  for word in ${definitions};
  do
    ban::check_word "${DIRECTORY}/${file}" "${word}"
  done
done

# suuccess result
if [[ "$errorcode" == "0" ]]
then
  console::write_success "conglaturations!! ban words not found from files in '${DIRECTORY}'\n${targetfiles}"
fi
exit $errorcode
