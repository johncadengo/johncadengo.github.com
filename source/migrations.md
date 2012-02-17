<link href="../markdown.css" rel="stylesheet"></link>

[SQLite Cheat Sheet](index.html)

MIGRATIONS
==========
Since we are using SQLite and it has limited `ALTER TABLE` support,
we have to do some gymnastics when it comes to changing table schemas.

Migrate Locations Table
-----------------------
Here we would like to change the primary key of a table from being composed 
of multiple columns back to a simple `id` taking advantage of the built in `rowid`.

The old schema went something like this,

    CREATE TABLE locations (
        placeid INTEGER, 
        lat FLOAT NOT NULL, 
        lng FLOAT NOT NULL, 
        rad_lat FLOAT, 
        rad_lng FLOAT, 
        sin_rad_lat FLOAT, 
        cos_rad_lat FLOAT, 
        PRIMARY KEY (lat, lng), 
        FOREIGN KEY(placeid) REFERENCES places (id)
    )
    
We want something more like this,

    CREATE TABLE locations (
        id INTEGER NOT NULL, 
        placeid INTEGER, 
        lat FLOAT NOT NULL, 
        lng FLOAT NOT NULL, 
        rad_lat FLOAT, 
        rad_lng FLOAT, 
        sin_rad_lat FLOAT, 
        cos_rad_lat FLOAT, 
        PRIMARY KEY (id), 
        FOREIGN KEY(placeid) REFERENCES places (id)
    )
    
In other words, we want to change the primary key from being the `lat` and `lng` values
to a garden-variety, self-incrementing `id`. We will use SQLite's built in `rowid` to accomplish this.

We run the following code, adapted from an [FAQ](http://www.sqlite.org/faq.html#q11),

    CREATE TEMPORARY TABLE locations_backup(
        	placeid INTEGER, 
        	lat FLOAT NOT NULL, 
        	lng FLOAT NOT NULL, 
        	rad_lat FLOAT, 
        	rad_lng FLOAT, 
        	sin_rad_lat FLOAT, 
        	cos_rad_lat FLOAT, 
        	PRIMARY KEY (lat, lng), 
        	FOREIGN KEY(placeid) REFERENCES places (id)
    );
    INSERT INTO locations_backup SELECT placeid,lat,lng,rad_lat,rad_lng,sin_rad_lat,cos_rad_lat FROM locations;
    DROP TABLE locations;
    CREATE TABLE locations (
        id INTEGER NOT NULL,
        placeid INTEGER, 
        lat FLOAT NOT NULL, 
        lng FLOAT NOT NULL, 
        rad_lat FLOAT, 
        rad_lng FLOAT, 
        sin_rad_lat FLOAT, 
        cos_rad_lat FLOAT,
        PRIMARY KEY(id),
        FOREIGN KEY(placeid) REFERENCES places (id)
    );
    INSERT INTO locations SELECT rowid,placeid,lat,lng,rad_lat,rad_lng,sin_rad_lat,cos_rad_lat FROM locations_backup;
    DROP TABLE locations_backup;
    
This basically creates a new temporary table, saves our existing data to it, drops the old table, 
creates a new one to replace it, and then restores the data back from the temporary table. It's a 
good old [swap](http://en.wikipedia.org/wiki/Swap_%28computer_science%29).

##### Note:
The temporary `locations_backup` table has less columns than the new `locations` table. The column
we are adding is `id` and that can be accomplished in the `SELECT` with `rowid` as shown above.
If we weren't using `rowid`, we'd have to figure out another way to account for the difference
in the number of columns. We could do it in two steps, for example, by first filling up the id,
then inserting the other columns.



