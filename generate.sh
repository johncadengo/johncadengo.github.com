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

echo "Done."