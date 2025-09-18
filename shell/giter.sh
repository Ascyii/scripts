#!/bin/sh

git add .
git commit -a -m 'auto commit'

git fetch -a
git pull

git push
