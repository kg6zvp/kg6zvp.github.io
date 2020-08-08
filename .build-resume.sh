#!/bin/bash

cat resume.md | sed 's:\\\\:\\:g' | tail -n +7 | sed 's/---/# Sam McCollum Resumé\n/' | grep -v 'Download Resume' > tmp.md
pandoc --variable urlcolor=cyan -V geometry:margin=2cm --from=gfm tmp.md -o static/Sam_McCollum_Resume.pdf
rm tmp.md
