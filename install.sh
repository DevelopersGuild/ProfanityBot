#!/bin/sh

# for use with the docker module since pip -r requirements does not work with scipy
while read module; do
  pip install $module
done < requirements.txt