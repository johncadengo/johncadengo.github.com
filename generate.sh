#!/bin/bash
FILES=./source/*
for fullfile in $FILES
do
    filename=$(basename $fullfile)
    extension=${filename##*.}
    filename=${filename%.*}

    echo "Generating markdown for $filename..."
    markdown2 $fullfile > ./output/$filename.html
done

echo "Generating index of the files we've just created."
./auto-index.sh ./output > ./output/index.html

echo "Committing it."
git commit -a -m "Generate."

echo "Pushing it."
git push origin master

echo "Pulling it remotely."
ssh cadengo@thedashapp.com 'cd Feedback && git pull'

echo "Done."