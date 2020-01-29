#!/bin/bash

# Diagnostic output:
echo "Using reporter: $INPUT_REPORTER"
echo "Using reporter: $INPUT_SETTINGS"
echo "Linting path: $INPUT_PATH"
echo 'flake8 --version:'
flake8 --version
echo '================================='
echo
ls
cat "$INPUT_SETTINGS"

# Runs flake8, possibly with reviewdog:
if [ "$INPUT_REPORTER" == 'terminal' ]; then
  output=$(flake8 "$INPUT_PATH" --config="$INPUT_SETTINGS")
  status="$?"
elif [ "$INPUT_REPORTER" == 'github-pr-review' ] ||
     [ "$INPUT_REPORTER" == 'github-pr-check' ]; then
  # We will need this token for `reviewdog` to work:
  export REVIEWDOG_GITHUB_API_TOKEN="$GITHUB_TOKEN"

  # Running special version of `flake8` to match the `reviewdog` format:
  output=$(flake8 "$INPUT_PATH" --config="$INPUT_SETTINGS" -v)
  echo "$output" | reviewdog -f=pep8 -reporter="$INPUT_REPORTER" -level=error
  # `reviewdog` does not fail with any status code, so we have to get dirty:
  status=$(test "$output" = ''; echo $?)
else
  output="Invalid action reporter specified: $INPUT_REPORTER"
  status=1
fi

# Sets the output variable for Github Action API:
echo "::set-output name=output::$output"
echo '================================='
echo

 Fail the build in case status code is not 0:
if [ "$status" != 0 ]; then
  echo "$output"
  echo "Process failed with the status code: $status"
  exit "$status"
fi
