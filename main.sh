#!/bin/sh

set -euo pipefail
#set -x

target="./main.yml"
rm "$target"
echo "# Derived from ./elasticsearch ./fluentd ./kibana" >> "$target"
echo "Creating main.yaml"

for file in $(find ./elasticsearch -type f -name "*.yaml" | sort) ; do
  echo "add " $file
  cat "$file" >> "$target"
  echo " " >> "$target"
  echo "---" >> "$target"
done


for file in $(find ./kibana -type f -name "*.yaml" | sort) ; do
  echo "add " $file
  cat "$file" >> "$target"
  echo " " >> "$target"
  echo "---" >> "$target"
done


for file in $(find ./fluentd -type f -name "*.yaml" | sort) ; do
  echo "add " $file
  cat "$file" >> "$target"
  echo " " >> "$target"
  echo "---" >> "$target"
done
