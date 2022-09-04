#!/bin/bash
echo "# MyLinuxSetup" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Garenium/MyLinuxSetup.git
git push -u origin main
