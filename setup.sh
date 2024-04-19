#!/usr/bin/bash

# Project
_HERE="$PWD"
_APP_NAME="name"
_APP_PATH="$PWD/$_APP_NAME"


# Root
touch setup.py
touch {settings,.secrets}.toml
touch requirements{-dev,-app,}.in

_ROOT_FILES=(
  "$HOME/pyproject.toml"
  "$HOME/.editorconfig"
)

for _FILE in ${_ROOT_FILES[@]}; do
  _FILENAME=$(echo "$_FILE" | sed 's/.*\///')

  if ! [[ -r "$_HERE/$_FILENAME" ]]; then
    cp "$_FILE" "$_HERE/$_FILENAME"
  fi
done


# Application
mkdir -p $_APP_PATH
touch $_APP_PATH/{VERSION.txt,{__main__,__init__}.py}


# Git
if ! [[ -r "$_HERE/.gitignore" ]]; then
  wget -q 'https://github.com/github/gitignore/raw/main/Python.gitignore' \
    -O "$_HERE/.gitignore"
fi

if ! grep -q ".secrets.toml" "$_HERE/.gitignore"; then
  echo '**.secrets.toml' >> "$_HERE/.gitignore"
fi
