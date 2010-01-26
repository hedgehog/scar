#!/usr/bin/env bash
pushd ./gh-pages
rm -rf *
cp --recursive ./../website/output/* .
git add .
git commit -a -m "Migrate nanoc3 co output to gh-pages $1"
git push --force origin gh-pages
popd
