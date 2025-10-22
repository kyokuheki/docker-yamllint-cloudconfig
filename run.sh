#!/bin/sh

set -euo pipefail

if [ "$1" -eq "--help" ] || [ "$#" -eq 0 ]; then
  echo Usage: docker run -it --rm -v /PATH/TO/YAML/FILE:/FILE:ro yamllint-cloudconfig /FILE [/FILE2]
fi

for i in "${@}"; do
  echo -- yamllint ------------------------------------------------------------
  /usr/local/bin/yamllint "$i"

  echo -- searching for duplicated usernames ----------------------------------
  /usr/local/bin/python3 /cloudconfiglint.py "$i"
done
