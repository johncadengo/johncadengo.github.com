<link href="../markdown.css" rel="stylesheet"></link>

[SQLite Cheat Sheet](index.html)

OPTIMIZATIONS
=============
[SQLite Optimization FAQ](http://web.utk.edu/~jplyon/sqlite/SQLite_optimization_FAQ.html) was a great help in compiling this.

Also, I will borrow his copyright notice,
    
    ** The author disclaims copyright to this material.
    ** In place of a legal notice, here is a blessing:
    **
    **    May you do good and not evil.
    **    May you find forgiveness for yourself and forgive others.
    **    May you share freely, never taking more than you give.

Pragmas
-------
Some default values to adjust include:

* synchronous
* cache_size
* temp_store

Also, when dealing with large data sets, and in the command line, set the following,

    .mode csv
    .output output.csv
    
This way it isn't output to the screen, but to a file. Note, however, that it will also redirect
pragma outputs as well. So if you aren't seeing responses to your commands, they are in the output file.

### Synchronous

