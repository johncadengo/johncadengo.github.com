#!/bin/bash
# usage: auto-index [dir]
# taken from: http://www.alecjacobson.com/weblog/?p=192
INDEX=`ls -1 $1/*.html | sed "s/^.*/      <li\>\<a\ href=\"&\"\>&\<\\/a\>\<\\/li\>/"`
echo "<html>
    <head>
        <link href=\"../markdown.css\" rel=\"stylesheet\"></link>
        <title>Index of $1</title>
    </head>
  <body>
    <h2>Index of $1</h2>
    <hr>
    <ui>
$INDEX
    <ui>
  </body>
</html>"