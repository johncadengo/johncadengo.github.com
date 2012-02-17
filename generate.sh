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

echo "Adding the new files to the git if they haven't already been."
git add output

echo "Comitting and pushing source to Github."
git commit -a -m "Generate."
git push gh source

echo "Committing and pushing master to Github."
cd output
git commit -a -m "Generate."
git push origin master
cd ..

#echo "Pulling it to thedashapp.com remotely."
#ssh cadengo@thedashapp.com 'cd Feedback && git pull'

echo "Done."