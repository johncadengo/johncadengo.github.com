<link href="../markdown.css" rel="stylesheet"></link>

[SQLite Cheat Sheet](index.html)

DELETES
=======
**Caution**: If typos are made, could adversely affect database.

Empty trash bin
---------------

    DELETE FROM places
    WHERE id IN 
    (SELECT places.id
    FROM placestags INNER JOIN places on places.id = placestags.placeid
    INNER JOIN tags on tags.id = placestags.tagid
    WHERE tags.type = "Trash")
    
Delete dangling tags
--------------------
Dangling tags are tags that have no places attached to them.

    DELETE FROM tags
    WHERE id IN 
    (SELECT tags.id
    FROM tags
    LEFT JOIN placestags on tags.id = placestags.tagid
    WHERE placestags.tagid IS NULL)