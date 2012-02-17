<link href="../markdown.css" rel="stylesheet"></link>

[SQLite Cheat Sheet](index.html)

QUERIES
=======
Generally harmless, but if LIMITs are not used, could take time.

Get the first 100 places in the trash bin
-----------------------------------------

    SELECT DISTINCT places.id, places.name, tags.id, tags.name, tags.type
    FROM placestags INNER JOIN places on places.id = placestags.placeid
    INNER JOIN tags on tags.id = placestags.tagid
    WHERE tags.type = "Trash"
    LIMIT 100
    
Get the frequency of the first 100 tags 
---------------------------------------

    SELECT count(*), tagid
    FROM placestags GROUP BY tagid
    LIMIT 100
    
Sample output (on ~260,000 rows, about 836ms):

    count(*) | tagid
    ----------------    
    120      | 1
    9        | 2
    
Get the IDs of the 100 least frequent tags
------------------------------------------
This is a single table query.

    SELECT count(*), tagid
    FROM placestags GROUP BY tagid
    ORDER BY count(*) asc
    LIMIT 100
    
If you want most frequent, change asc in the ORDER BY above to desc.
    
Sample output (on ~260,000 rows, about 947ms):

    count(*) | tagid
    ----------------    
    1        | 4
    1        | 14
    1        | 21

Get the names of the 100 least frequent tags
--------------------------------------------
This query requires multiple tables.

    SELECT count(*), tags.name
    FROM (placestags INNER JOIN places on places.id = placestags.placeid
               INNER JOIN tags on tags.id = placestags.tagid)
    GROUP BY tags.id
    ORDER BY count(*) asc
    LIMIT 100
    
If you want most frequent, change asc in the ORDER BY above to desc.

Sample output (on ~260,000 rows, about 1506ms):

    count(*) | name
    ------------------------
    1        | quick
    1        | good morning
    1        | spicy redneck

Get the first 100 dangling tags
-------------------------------
Dangling tags are tags that have no places attached to them.

Should always return nothing. I had to manually put in a false tag to test it.

    SELECT tags.id, tags.name
    FROM tags
    LEFT JOIN placestags on tags.id = placestags.tagid
    WHERE placestags.tagid IS NULL
    LIMIT 100
    
Get all tags which have only occurred once
------------------------------------------
This includes tags of type "Category" and "Dish", etc.

    SELECT count(*) AS freq, tags.name, tags.type
    FROM (placestags INNER JOIN places on places.id = placestags.placeid
               INNER JOIN tags on tags.id = placestags.tagid)
    GROUP BY tags.id
    HAVING freq = 1

Sample output (on ~260,000 rows, about 1739ms):

    freq | name           | type
    --------------------------------
    1    | quick          | Tag
    1    | good morning   | Tag
    1    | spicy redneck  | Dish
    1    | kobe beef roll | Category
    
### By type
Change last line `HAVING freq = 1` to `HAVING freq=1 and tags.type="Category"` 
if you only want to get a specific type of tag. 

As of this example, only 87 Categories have been tagged once.

    SELECT count(*) AS freq, tags.id AS CategoryID, tags.name AS CategoryName, places.id AS PlaceID, places.name AS PlaceName
    FROM (placestags INNER JOIN places on places.id = placestags.placeid
               INNER JOIN tags on tags.id = placestags.tagid)
    GROUP BY tags.id
    HAVING freq = 1 and tags.type="Category"

Get all the places which have no locations
------------------------------------------

    SELECT places.id, places.name
    FROM places LEFT JOIN locations on locations.placeid = places.id
    WHERE locations.placeid IS NULL

Get all the places with address like
------------------------------------
Here we are using the search string `'%carson%'` which will return
any places with an address that contains the word "carson" in it.

##### Note:
The `%` are wildcard characters.

    SELECT places.id, places.name, places.address
    FROM places 
    WHERE places.address like '%carson%'

Sample output (on ~16,000 rows, about 25 ms)

    id     | name               | address
    -----------------------------------------------------------
    17361  | RA Sushi           | 3525 W Carson St # 161 90503
    17390  | BJ's Restaurant    | 2525 W. Carson Street 90503
    17410  | Buffalo Wild Wings | 3525 West Carson Street 90503
    
Get all the places which share two tags
---------------------------------------
Taken from [stackoverflow](http://stackoverflow.com/a/9219481/693754).

    SELECT places.name FROM places 
      INNER JOIN placestags ON places.id=placestags.placeid 
      WHERE placestags.tagid = 79
    INTERSECT 
    SELECT places.name FROM places 
      INNER JOIN placestags ON places.id=placestags.placeid 
      WHERE placestags.tagid = 81;

In the above example, we find the tags by `id`. We can also get the tag by `name`,

    SELECT places.name FROM placestags 
      INNER JOIN places ON places.id=placestags.placeid 
      INNER JOIN tags ON tags.id=placestags.tagid
      WHERE tags.name = "japanese"
    INTERSECT 
    SELECT places.name FROM placestags 
      INNER JOIN places ON places.id=placestags.placeid 
      INNER JOIN tags ON tags.id=placestags.tagid
      WHERE tags.name = "korean";
      
The first example is very fast. On ~260,000 rows it took about 103ms.
The second query is a bit more complicated since we are adding an extra
join, but it is still relatively quick. On ~260,000 rows it took about 543 ms.

##### Note:
Remember when searching for tags by name that the query is case sensitive. 
