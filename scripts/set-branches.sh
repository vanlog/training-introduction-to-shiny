#!/bin/bash

set -e
set -u

function gcob() {
  branch="$1"
  git checkout $branch || git checkout -b $branch
}

function greset() {
  git reset --hard $1
}



gcob 0.16 && greset main
gcob 0.15 && greset 0.16^
gcob 0.14 && greset 0.15^
gcob 0.13 && greset 0.14^
gcob 0.12 && greset 0.13^
gcob 0.11 && greset 0.12^
gcob 0.10 && greset 0.11^
gcob 0.9 && greset 0.10^
gcob 0.8 && greset 0.9^^
gcob 0.7 && greset 0.8^
gcob 0.6 && greset 0.7^
gcob 0.5 && greset 0.6^
gcob 0.4 && greset 0.5^
gcob 0.3 && greset 0.4^
gcob 0.1 && greset 0.3^
gcob 0.0 && greset 0.1^

# git push --all -f
