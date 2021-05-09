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



gcob 1.13 && greset main
gcob 1.12.1 && greset 1.13^
gcob 1.11 && greset 1.12.1^
gcob 1.10 && greset 1.11^
gcob 1.9 && greset 1.10^
gcob 1.8 && greset 1.9^
gcob 1.7 && greset 1.8^
gcob 1.6 && greset 1.7^
gcob 1.5 && greset 1.6^
gcob 1.4 && greset 1.5^
gcob 1.3 && greset 1.4^
gcob 1.2 && greset 1.3^
gcob 1.1 && greset 1.2^
gcob 1.0 && greset 1.1^
gcob 0.16 && greset 1.0
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

git push dev --all -f

# git push origin --all -f
# git push origin :dev-slides





