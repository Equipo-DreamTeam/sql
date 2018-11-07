# Structured Query Language (SQL) Study

| Section       | Directions SQL Study                                         |
| ------------- | ------------------------------------------------------------ |
| Introduction  | Use [PostgreSQL](http://www.postgresql.org/) documentation as the reference for SQL commands. |
| Prerequisites | None                                                         |
| Instructions  | Directions were given in separate `study.md` file.           |

###### Objectives SQL Study

-   List the notational conventions used in the synopses of PostgreSQL commands.
-   List the PostgreSQL commands to create a new or remove an existing database.
-   List the SQL commands to create or remove a database table.
-   List the SQL commands used to create, read, update, and delete rows in a database table.

## Notational conventions

Show and name the characters that denote optional parts of a command

```md
`[]` brackets
`{}` braces and `|` vertical lines indicate that we have to choose one alternative
```

Show and name the characters that indicate a possible repeating element in a command

```md
`...` dots
```

## Creating or removing a database

What shell command would you execute to **create a database** named `mydb`?

```sh
createdb mydb
```

What shell command would you execute to **remove a database** named `mydb`?

```sh
dropdb mydb
```

## Creating or removing a table

What two SQL keywords precede the table name when creating a database table?

```sql
CREATE TABLE
```

What is the SQL command to remove a database table named `mytable`?

```sql
DROP TABLE
```

## Table row CRUD

What two SQL keywords precede the table name when populating a database table with rows?

```sql
INSERT INTO
```

What SQL keyword starts the command to retrieve data from a database table?

```sql
SELECT
```

What SQL command is used to update existing rows in a database table?

```sql
UPDATE
```

What SQL command is used to remove rows from a database table?

```sql
DELETE FROM <tablename> WHERE <colum_name> = <record_property>
```

- *~Careful with this command, using DELETE FROM <tablename> will delete all rows from the table.~*



# An introduction to relational databases

###### Prerequisites to An Intro to Relational Databases

- A working **[PostgreSQL](https://www.postgresql.org/)** installation.
- [SQL Study](https://git.generalassemb.ly/ga-wdi-boston/sql-study)

###### Objectives of An Intro to Relational Databases

- Create a database table
- Insert a row or rows into a database table
- Retrieve a row or rows from a database table
- Modify a database table after creation
- Update a row or rows in a database table
- Delete a row or rows from a database table

## Introduction

Most apps need a [data store](https://en.wikipedia.org/wiki/Data_store) <u>to persist important information</u>. A relational database is the most common datastore for a web application. SQL is the language of relational databases.

My notes: (wikipedia)

A data store is a repository for persistently storing and managing collections of data which include not just repositories like databases, but also simpler store types such as simple files, emails etc.[1]

A database is a series of bytes that is managed by a database management system (DBMS). A file is a series of bytes that is managed by a file system. Thus, any database or file is a series of bytes that, once stored, is called a data store.

At it's simplest, a relational database is a mechanism to store and retrieve data in a tabular form. Spreadsheets are a good analogy. Individual sheets as tables and the whole spreadsheet as a database. See **[this link](https://docs.google.com/spreadsheets/d/11oSk85me0klRDfa6o7OfkzMVnvOuhxsF9W-bQEPP5wk/edit?usp=sharing)** for an example.

Why is this important?

Database tables are a good place to store key/value pairs, as long as the values are simple types (e.g. string, number). The keys are the column names and the values are stored in each row. That maps well to simple JSON objects. A group of rows from one table maps well to a JSON array.

What about more complicated data?

Database tables can reference other tables which allows arbitrary nesting of groups of simple types. This is something we'll be looking at more closely later.

### Relational Database Management System ([RDBMS](http://en.wikipedia.org/wiki/Relational_database_management_system))

A **[Database Server](http://upload.wikimedia.org/wikipedia/commons/5/57/RDBMS_structure.png)** is a set of processes and files that manage the databases that store the tables. Sticking with our previous analogy a database server would map to Google Sheets (_or Excel spreadsheet_).

### Verb Equivalence

**[CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete)**
_(create, read, update and delete)_, SQL, HTTP, and Rails Controller action.

| CRUD   | SQL    | HTTP   | action     |
| :----- | :----- | :----- | :--------- |
| Create | INSERT | POST   | create     |
| Read   | SELECT | GET    | index/show |
| Update | UPDATE | PATCH  | update     |
| Delete | DELETE | DELETE | destroy    |

## PostgreSQL

**[PostgreSQL](https://www.postgresql.org/)**, a popular open source database server, should already be installed on your computer.

_On Macs_ you can run `brew services list` to see if PostgreSQL is running.

- If the server isn't running, `status` not `started`, start it using`brew services start postgresql`.
- _On Linux_ `service --status-all | grep postgresql` to check if it's running.
  (it will return [ + ] if it's running and [ - ] if it's not.

- To start it if it's not running, do `sudo service postgresql start`.

## CREATE DATABASE

Use `sql-list` as the database to hold our tables and **[psql](https://www.postgresql.org/docs/9.6/static/app-psql.html)** to interact with it.  `psql` is PostgreSQL's **command line client** which lets us execute SQL commands interactively (REPL-like) and from scripts.  `psql` has useful built in commands.

- [ ] Access psql CLC in terminal: `psql`

- [ ] To check which client version of Postgres is installed in Mac: `SELECT version()`(run inside psql). These repo notes refer to commands for Postgres version 10.4.
  For a cheatsheet of `mySQL` commands; see https://gist.github.com/hofmannsven/9164408.

- [ ] To see a list of all DBs from the terminal: `psql -l`

- [ ] Create the database.  In psql CLC: `CREATE DATABASE "sql-list";`

  Use the **[CREATE DATABASE](https://www.postgresql.org/docs/9.6/static/sql-createdatabase.html)** command from within `psql`.  This is a **[SQL](https://www.postgresql.org/docs/9.6/static/sql.html)** _(Structure Query Language - see also the [Wikipedia article](http://en.wikipedia.org/wiki/SQL))_ command and requires that we wrap the database name in double quotes (i.e. `create database "sql-list";`). A hyphen `-` is not allowed as a name character in SQL unless the name is surrounded with double-quotes.

- [ ] Connect to the database just created: `\c sql-list`

  - [ ] Or connect  from the command line using: `psql sql-list`
  - [ ] For help with built-in commands: `sql-list=> help`
  - [ ] Be careful with running just `psql`, without an argument, because that will connect us to our default database, usually named with our login. We may then create tables inside the wrong db!

- [ ] To see a list all DBs created in the server: `-l` or `\l` 

- [ ] To see information about the  objects in the current database: `\d`

- [ ] To read commands from a file: \i

- [ ] To be sure we're in the right DB: (not sure what this means but use the command exactly as is): `sql-list=> select current_catalog;`

- [ ] Note that to be sure the commands are being executed against the DB you're in, always use the database name `sql-list`

- [ ] To disconnect from the DB: `Ctrl + d` or `\q`

- [ ] To remove a database - *be careful, this is unrecoverable* - use the [DROP DATABASE](https://www.postgresql.org/docs/9.6/static/sql-dropdatabase.html) command.

###### TABLES

We create a table to define the names and types of data we want to store. Use PostgreSQL's documentation - is extensive and excellent.

By convention, tables are named with the pluralization of the name of the object whose data they hold. By another convention, each table will have an `id` column that uniquely identifies each row. This unique `id` is the `PRIMARY KEY` of the table.

- [ ] See a list of all tables inside a DB: `\dt`

- [ ] Create Table inside sql-list DB: `CREATE TABLE words(id SERIAL PRIMARY KEY, grouping_english TEXT, english TEXT, grouping_spanish TEXT, spanish TEXT, description_english TEXT, description_spanish TEXT);`

  CREATE TABLE <table_name> (column-name DATA-TYPE, column-name DATA-TYPE, column-name DATA-TYPE);

- [ ] See Table: `SELECT * FROM words;`

  Shows the words table with 0 rows

- [ ] Bulk-copy data from .`csv` file to populate *words* table: `\copy words(grouping_english, english, grouping_spanish, spanish, description_english, description_spanish) FROM '/Users/beatriz/wdi/projects-data-files/words.csv' WITH (FORMAT csv, HEADER true) `

  - [ ] For inserting bulk data, PostgreSQL provides the `COPY` command. But that command executes relative to the server installation, so it's best to use *psq's meta-command* `\copy` allowing us to load data relative to where we run `psql`. Bulk loading is something available with most RDBMSs, but the specific commands and capabilities vary.
  - [ ] Using an Excel csv file created issues. Once the file was opened as an LibreOffice document, the \copy command worked.

- [ ] See table again, this time we'll see a lot of rows that came from the .csv file: `SELECT * FROM words;`
  Press `space bar`  or `CTRL + v` to page through the table

- [ ] We can save the SQL commands in a `scripts` file with a `.sql` file extension and then just run the script. To run the script from the terminal:  `psql <db-name> --file=<path-to-file>`
  To run the script from inside psql:   `\i <file>`.
  Example: save the SQL statement to create a words table in `scripts/library/000_create_table_words.sql`. 

- [ ] Store the command we used to load data in bulk in a `.psql` file:  `scripts/library/020_bulk_load_words.psql`

- [ ] To delete a table, ex. the `words`table: `DROP TABLE IF EXISTS words;`
  `IF EXISTS` avoids errors if the table we want to drop doesn't exist.
  More at: http://www.postgresqltutorial.com/postgresql-drop-table/

###### QUERIES: Selecting Columns, Retrieving, Sorting, & Filtering Rows

Query statements provide a mechanism to retrieve and summarize the data in the database.

- [ ] To see all data from the `words` table: `SELECT * FROM words;`
- [ ] To see all rows of just one column: `SELECT spanish FROM words;`
- [ ] To sort the Spanish words from a to z: `SELECT english, spanish FROM words ORDER BY spanish ASC;` (ASC is the default sort & can be omitted)
- [ ] To sort the English words from z to a: `SELECT english, spanish FROM words ORDER BY english DESC;`
- [ ] To filter with the WHERE clause and the `=` operator: `SELECT english, spanish FROM words WHERE english = 'Graft';`
- [ ] To make the above query case-insensitive: `SELECT english,spanish FROM words WHERE LOWER(english) = LOWER('graft');`

###### Adding Rows to a Table: INSERT INTO

- [ ] Insert rows into the `words` table: `INSERT INTO words (english, spanish) VALUES ('hello', 'hola'), ('goodbye', 'adios');`
- [ ] Store the command in a `.sql` file:  `scripts/library/030_insert_into_words.psql`

###### Removing Rows from a Table: DELETE FROM

- [ ] Remove one row from the `words` table: `DELETE FROM words WHERE english = 'hello';`
- [ ] Remove all raws from a table: `DELETE FROM <table-name>` or `TRUNCATE <table-name>`

###### Updating a Row

- [ ] To update the Spanish words in the words table: `UPDATE words SET spanish = 'adios, chao, nos vemos' WHERE spanish = 'adios';`
- [ ] Two other examples from the Postgres [docs](https://www.postgresql.org/docs/9.6/static/dml-update.html): 
  `UPDATE products SET price = 10 WHERE price = 5;`
  `UPDATE products SET price = price * 1.10;`



###### Changing the Structure of a Table: ALTER TABLE

Used to add/remove columns and/or constraints, change default values or column data types, rename columns or tables.

- [ ] To add a Portuguese column to the `words` table: `ALTER TABLE words ADD COLUMN portuguese text;`
- [ ] To drop the Portuguese column to the `words` table: `ALTER TABLE words DROP COLUMN portuguese CASCADE;` (CASCADE tells Postgres to drop everything that may be linked to the column being dropped)
- [ ] To change a column name: `ALTER TABLE groupings RENAME COLUMN grouping_spansih TO grouping_spanish;`

# An Introduction to PostgreSQL Foreign Key References

In the previous material on SQL we used the phrase "relational database" but didn't delve into what that means. We'll begin to cover the topic of "relationships" in database terms now.

###### Prerequisites

- [SQL](https://git.generalassemb.ly/ga-wdi-boston/sql)

###### Objectives

- Add a foreign key reference to an existing table.
- Update a row setting a reference to the id of a row in another table.
- Insert a row which includes a reference to the id of a row in another table.
- Retrieve rows from two tables using a `JOIN` condition

###### Creating Related Tables / Modeling (diagramming) relationships

Model (diagram) new objects (things) and their relationship to existing objects (things).

- [ ] Create a related `groupings` table:  `CREATE TABLE groupings(id SERIAL PRIMARY KEY, grouping_english TEXT, grouping_spanish TEXT);`

- [ ] Use the `words` table to populate the `groupings	` table: `INSERT INTO groupings(grouping_english,grouping_spanish) SELECT DISTINCT grouping_english, grouping_spanish FROM words ORDER BY grouping_english;`

  <hr>

- [ ] Create a related `descriptions` table:  `CREATE TABLE descriptions(id SERIAL PRIMARY KEY, description_english TEXT, description_spanish TEXT);`

- [ ] Use the `words` table to populate the `descriptions	` table: `INSERT INTO descriptions(description_english,description_spanish) SELECT DISTINCT description_english,description_spanish FROM words ORDER BY description_english;`

- [ ] Create the SQL scripts noted above.




## Adding references from one table to another

Conventionally, a foreign key reference is named for the singular of the name of the table being referenced, with the column being referenced appended after an underscore. So if we're adding a reference to the `cities` table and its `id` column we'll create a column called `city_id`. However, _this convention should
not be followed when there is a semantically superior name available. 

- [ ] Add grouping_id to `words` table: `ALTER TABLE words ADD COLUMN grouping_id INTEGER REFERENCES groupings(id); CREATE INDEX ON words(grouping_id);`
- [ ] Populate the grouping reference in the `words` table: UPDATE words SET grouping_id = groupings.id FROM groupings WHERE words.grouping_english = groupings.grouping_english AND words.grouping_spanish = groupings.grouping_spanish;
- [ ] Remove the `grouping_english` and the `grouping_spanish` columns from the `words` table: `ALTER TABLE words DROP COLUMN grouping_english, DROP COLUMN grouping_spanish;`

<hr>

- [ ] Add description_id to `words` table: `ALTER TABLE words ADD COLUMN description_id INTEGER REFERENCES descriptions(id); CREATE INDEX ON words(description_id);`
- [ ] Populate the description reference in the `words` table: `UPDATE words SET description_id = descriptions.id FROM descriptions WHERE words.description_english = descriptions.description_english AND words.description_spanish = descriptions.description_spanish;`
- [ ] Remove the `description_english` and the `descriptiong_spanish` columns from the `words` table: `ALTER TABLE words DROP COLUMN description_english, DROP COLUMN description_spanish;`



## Retrieving rows from related tables

### Demonstration: Retrieve information about authors and books

We'll create scripts in `scripts/library` to retrieve books by a set of authors and authors of certain books.

What happens if we try to `DELETE` an author?

### Code along: Retrieve information about doctors and patients

We'll create scripts in `scripts/clinic` to retrieve doctors and a count of patients that are assigned to them.

### Lab: Retrieve information about recipes and ingredients

We'll create scripts in `scripts/cookbook` to retrieve ingredients for a recipe. Later we'll see how to connect multiple recipes to the same ingredients.

## Advanced SQL: Joins

Imagine we have filing cabinets and paper spreadsheets instead of a digital database. You're tasked with assembling information from two paper spreadsheets. You have a sheet of authors with ids and a sheet of books with author_ids. You must answer the question: "Which books were written by either Ernest Hemingway or Shirley Jackson?"

You first take the sheet with authors, find the each author and note their ids on a third sheet. Then, you look at the books sheet and scan for Hemingway's id to appear as author id. Each time you come across a matching row, you write all the data from the books sheet, along with Hemingway's name, on your third sheet. Then you repeat the process again for Jackson.

When you're done, you have a third sheet that's an artifact of the process. It can be recreated at any time by following the steps you just went through. You take your two original sheets and put them back in the filing cabinet for the next person to use.

The process of collating the information from each of the two sheets to the third is called a JOIN, and that's why our join clause matches the id from one table with the foreign key from another.

The resulting third sheet can be called a report, and it represents a particular presentation of data from two different tables. When we run queries, we generate reports. The viewing of data and storing of data in SQL are different. The report is not a table, and the table is not a report.

## Additional Lab:

Assign adults (patients with age 16-64) to General practice doctors (doctors with specialty General practice). Do so using temporary tables and creating temporary sequences.

- [More on sequence and temporary sequence](https://www.postgresql.org/docs/9.6/static/sql-createsequence.htm)



# An Introduction to PostgreSQL Foreign Keys

###### Objectives

- Add a foreign key reference to an existing table.
- Insert a row which includes a reference to the id of a row in another table.
- Update a row setting a reference to the id of a row in another table.
- Retrieve rows from two tables using a `JOIN` condition

###### Prerequisites

- [An introduction to relational databases](https://github.com/ga-wdi-boston/sql-crud)

## Putting the 'Relation' in 'Relational Database'

In conversations about Postgres, SQL and the like, you may hear the term **_relational database_** thrown around. In the previous material on SQL, you learned how to create, modify, and destroy rows and tables.
How do 'relationships' (whatever that means) fit into that context?

Suppose that we had two separate tables of information in our database, `developers` and `lunches` (see below). Each developer brings their own lunch, and none of them want to eat each others' lunches, so we have to make sure that each lunch lines up with the right developer. How might we do that?

**developers**

|  id  | first_name | last_name | favorite language |
| :--: | :--------: | :-------: | :---------------: |
|  1   |   Antony   |  Donovan  |         C         |
|  2   |   Jason    |   Weeks   |    JavaScript     |
|  3   |   Lauren   |   Fazah   |       Ruby        |
|  4   |    Ross    |  Degnen   |      LOLCODE      |

**lunches**

|  id  |             main_course              |     side_dish      |
| :--: | :----------------------------------: | :----------------: |
|  1   |     salmon and tuna sushi rolls      |       chili        |
|  2   | cheese sandwich on gluten-free bread |       salad        |
|  3   |         roast beef sandwich          |       chips        |
|  4   |           chicken sandwich           | steamed vegetables |

What if we were to put nametags on each of the lunches, so that we could know which developer brought which lunch?

**lunches**

|  id  | developer |             main_course              |     side_dish      |
| :--: | :-------: | :----------------------------------: | :----------------: |
|  1   |  Lauren   |     salmon and tuna sushi rolls      |       chili        |
|  2   |  Antony   | cheese sandwich on gluten-free bread |       salad        |
|  3   |   Ross    |         roast beef sandwich          |       chips        |
|  4   |   Jason   |           chicken sandwich           | steamed vegetables |

We've now associated (i.e. related) each `lunch` record with a `developer` record. But what if another developer with a duplicate name joins the mix? It might be better to use something unique, like the `id` column, instead.

|  id  | developer_id |             main_course              |     side_dish      |
| :--: | :----------: | :----------------------------------: | :----------------: |
|  1   |      3       |     salmon and tuna sushi rolls      |       chili        |
|  2   |      1       | cheese sandwich on gluten-free bread |       salad        |
|  3   |      4       |         roast beef sandwich          |       chips        |
|  4   |      2       |           chicken sandwich           | steamed vegetables |

The `developer_id` column refers to data in the `developers` table, but it's actually a column in the `lunches` table. This is what's known as a **foreign key**.

In terms of actual implementation in an **RDBMS** ( _relational database management system_ ), a column can be defined as holding foreign keys using a modifier on a table definition called a **constraint**. Ex. of constraints:

- NOT NULL
- UNIQUE
- PRIMARY KEY
- FOREIGN KEY
- CHECK

Each of these constraints allows you to put some bounds on the values that can be put into specific columns. The FOREIGN KEY constraint in particular makes sure that  values in that column are always valid `id` values  in the table that the column refers to.

When adding a FOREIGN KEY constraint to a column,  an INDEX constraint is also usually added to that same column  in order to speed access to matched rows.  The combination of FOREIGN KEY and INDEX tells the RDBMS  how you intend to use the tables you've related.

In the 'developers and lunches' example, one lunch was associated with one developer.
This is called a **1 to 1** relationship. However, there are several other possible arangements,
including **1 to (0 or 1)**, **1 to (0+)**, and **(0+) to (0+)**. The last two are frequently called 'one-to-many' and 'many-to-many'; we'll look at the first of these now, and the second in later materials.

## Setup

### Code Along : Create a Database

Let's create a working database for the next few exercises  using the **[CREATE DATABASE](http://www.postgresql.org/docs/9.4/static/sql-createdatabase.html)** command;  we'll name it `sql-join`, and base it on the  `sql-crud` database from the previous SQL material.

**bash**

```bash
psql
```

**psql**

```sql
psql (9.4.5)
Type "help" for help.

wdi=> CREATE DATABASE "sql-join" TEMPLATE "sql-crud";
CREATE DATABASE
wdi=> \c sql-join
You are now connected to database "sql-join" as user "wdi".
sql-join=>
```

------

## Create a Foreign Key

### Demo : Create a Foreign Key

Take a look at how a foreign key can be added to an existing table: `people`. Specifically, we'll add a reference to the city in which each person was born. Adding a new foreign key column is just like adding any other new column -- it's an `ALTER TABLE` operation.

 Watch as i:

- Create a `people` table
- Create a `cities` table
- Alter `people` table to have `born_in_id` and relate it to the `cities`  table.

### Code Along : Create a Foreign Key

Let's try creating some more foreign keys. First, let's create an `addresses` table which references the `cities` table. In the `data` directory,  there's a CSV file called `addresses.csv` with a lot of address data in it. The columns are 'no' (i.e. number) and 'name',  so let's represent these columns as INTEGER and CHARACTER VARYING / VARCHAR,  respectively. As mentioned, we also want each address to reference the city that it's in,  so let's add another column to do that.

```sql
CREATE TABLE addresses(
  id SERIAL PRIMARY KEY,
  no INTEGER,
  name VARCHAR, -- CHARACTER VARYING
  city_id INTEGER REFERENCES cities -- defaults to (id)
);
```

Alter the table: add a reference  from the `people` table to the `addresses` table.

```sql
ALTER TABLE people
  ADD COLUMN address_id INTEGER REFERENCES addresses
;
```

### Lab : Create a Foreign Key

Write SQL code inside the various script files that adds an owner reference to the pets table.  You will need to repeat many of the steps we have just performed in order to do this.

------

## Relate Rows in Different Tables

### Demo : Relate Rows in Different Tables

Now that we've created some foreign key columns, it's possible to insert new rows into those tables that reference other tables, or even to update existing rows and add new references that way. We could easily do this with the born_in_id column we just created.

Note that a foreign key constraint will disallow invalid values in the referencing column.

- Insets a city into the `cities` table
- Insert a person in the `people` table that refrences a the city

### Code Along : Relate Rows in Different Tables

We'll start by inserting a new address into the `addresses` table  that's associated with Somerville.

```sql
INSERT INTO addresses(no,name, city_id)
  VALUES (255, 'Elm Street', 1)
  -- In `cities`, Somerville has an ID of 1
;
```

Let's check to make sure we updated the entry:

```sql
SELECT name FROM addresses WHERE city_id = 1;
```

Now that we have created the table let's bulk upload the data. In `bulk_load/addresses.psql` write the command to bull upload information from the addresses csv file.

```bash
\copy addresses(no,name) from 'data/addresses.csv' with(header true, format csv)
```

and in psql let's run the script

```bash
\i <path/to/file>
```

Let's bulk upload some people using the same process as well.

Now update the `people` table  by associating people with some addresses.

```sql
UPDATE people AS p        -- alias `people` as p
  SET address_id = a.id
    FROM addresses AS a   -- alias `addresses` as a
      WHERE a.id = p.id   -- arbitarily associate person 1 with address 1
;
```

You people IDs and address IDs may not be in sync, you may need to do some math here.

### Lab : Relate Rows in Different Tables

Define owner references for some existing pets. Then, pick at least two people to be folks with too many pets --  these people should have large numbers of pets associated with them. Finally, for each one of these 'pet hoarders',  add a new pet and associate it with a hoarder.

------

## Read Data Across Related Tables

### Demo : Read Data Across Related Tables

Now that our rows are related,  it would be nice if we could read across multiple tables at once - for instance, to see how many people lived in some particular city. One possible way to accomplish this is to add a special clause,  called a JOIN clause,  to a SELECT command;  this allows queries to return associated data from two tables as a single row.

Note: The number may vary here due to IDs in the database, and the math you used earlier.

```sql
SELECT c.name, COUNT(*)
  FROM people p
  INNER JOIN cities c ON p.born_in_id = c.id
    GROUP BY c.name
  -- list cities by how many people were born there
;
```

```sql
SELECT c.name, COUNT(*)
  FROM people p
  INNER JOIN cities c ON p.address_id = c.id
    GROUP BY c.name
;
```

Depending on the type of JOIN we use, we can grab different sets of rows from one table or the other.
An 'inner join' of two tables, A and B, grabs only those rows in table A that have a matching row in table B, and vice versa. Thus, if we're using an INNER JOIN, we can even reverse the order of the tables without changing anything.

```sql
SELECT c.name, COUNT(*)
  FROM cities c
  INNER JOIN people p ON p.born_in_id = c.id
    GROUP BY c.name
  -- list cities by how many people were born there
;
```

We could also look at people born in a particular city.

```sql
SELECT p.first_name, p.last_name
  FROM people p
  INNER JOIN cities c ON p.born_in_id = c.id
    WHERE c.name = 'Somerville'
;
```

### Code Along : Read Data Across Related Tables

Write some queries that focus on people, addresses, and cities. Run the script in `update/addresses.sql` to arbitrarily associates addresses with cities.  Be sure to check that the people IDs and addresses correctly align. To get a list of all people, along with their address and city, we could write

```sql
SELECT p.last_name, p.first_name, a.name AS street
  FROM people p
  INNER JOIN addresses a  ON p.address_id = a.id
;
```

### Lab : Read Data Across Related Tables

Run this SQL code to arbitrarily assign pets to people.

```sql
UPDATE pets
  SET owner_id = 7
    WHERE kind = 'fish' AND name LIKE 'S%'
;

UPDATE pets
  SET owner_id = 11
    WHERE kind = 'bird'
;

UPDATE pets
  SET owner_id = 21
   WHERE kind = 'cat'
;

UPDATE pets
  SET owner_id = 42
    WHERE kind = 'dog'
;
```

Now use SELECT to come up with a list of all of the hoarders - that's anyone with more than 3 dogs, 4 birds, 5 cats, or 20 fish.

> HINT: Look up UNION and see what it does.

------

# An Introduction to many-to-many relationships in PostgreSQL

Instructor: Arjun,  Monday, July 16, 2018

###### Prerequisites

- [An Introduction to PostgreSQL Foreign Keys](https://git.generalassemb.ly/ga-wdi-boston/sql-references)

###### Objectives

- Create tables with foreign key references.
- Create join tables to represent many-to-many relationships.
- Insert rows in join tables to create many-to-many relationships.
- Select data about many-to-many relationships using **join tables**.

## Modeling relationships

Our library has books and authors, but it won't be much of a library without borrowers.  Our clinic has patients and doctors, but how do we schedule appointments? Our cookbook has ingredients and recipes, but only allows a particular ingredient in a single recipe.

- In our library, how do we connect `borrowers` to `books`.
- How should clinic administrators record appointments?
- What does our cookbook need to include ingredients in recipes?

Let's model these new entities (objects) and their relationships to our existing entities (objects).

## Creating many-to-many relationships between entities

In an RDBMs, we do this using join tables

### Demonstration: Create tables for borrowers and loans

We'll create SQL scripts in `scripts/library` to add a `borrowers` table and populate it from data in the `patients` table (since we only need a subset of the columns from `data/people.csv`).

Then we'll create a `loans` table and populate it using `INSERT` statements.

### Code along: Create and populate an appointments table

We'll create scripts in `scripts/clinic` to add an `appointments` table and populate it using `INSERT` statements.

### Lab: Create and populate a recipe_ingredients table

We'll create scripts in `scripts/cookbook` to add a `recipe_ingredients` table and populate it using `INSERT` statements.  Then we'll remove `recipe_id` from `ingredients`.

## Retrieving data using join tables

### Demonstration: Retrieve information about library loans

We'll create scripts in `scripts/library` to retrieve information about borrowers, loans, and books. What happens if we try to `DELETE` a borrower or a book?

### Code along: Retrieve information about appointments

We'll create scripts in `scripts/clinic` to retrieve information about patients, doctors and appointments.

### Lab: Retrieve information about recipe ingredients

We'll create scripts in `scripts/cookbook` to retrieve information about recipes.

# Many-to-Many Relationships in PostgreSQL

###### Objectives

- Create tables with foreign key references.
- Create join tables to represent many-to-many relationships.
- Insert rows in join tables to create many-to-many relationships.
- Select data about many-to-many relationships using join tables.

###### Prerequisites

- [An Introduction to PostgreSQL Foreign Key References](https://github.com/ga-wdi-boston/sql-references-join)

## Handling More Complex Data Relationships

There are a variety of relationships that cannot be easily captured by the simple one-to-many relationships we've looked at so far. Suppose you were making an application for planning and attending events. Presumably, event will generally have more than one person attending. But one person might also attend multuple events. This is an example of a many to many relationship.

The way most many-to-many relationships are represented is using _join tables_. A join table is a table, containing two sets of foreign keys, that defines a bi-directional relationship between the two other tables
that those foreign keys refer to. Each row in the join table relates one row in the 'left' table  with one row in the 'right' table (left and right are arbitrary). The same 'left' reference may appear with many different 'right' references and vice versa.

In the example above, we might have a `people` table and an `events` table. A join table would create a cross-reference between these two tables, with each row linking one person to one event.

**people_events**

|  id  | person_id | event_id |
| :--: | :-------: | :------: |
|  1   |     5     |    4     |
|  2   |     7     |    4     |
|  3   |     9     |    4     |
|  4   |     5     |    4     |
|  5   |     5     |    4     |

It's usually helpful to model these joins as their own entities, where possible, since that will give your table a more semantic name. In doing so, you will also commonly find yourself adding additional columns to the table to represent other properties of the entities.

**attendances**

|  id  | person_id | event_id | other_data |
| :--: | :-------: | :------: | :--------: |
|  1   |     5     |    4     |    ...     |
|  2   |     7     |    4     |    ...     |
|  3   |     9     |    4     |    ...     |
|  4   |     5     |    4     |    ...     |
|  5   |     5     |    4     |    ...     |

## Setup

### Code Along : Create a Database

Use `sql-join-tables` as the working database. As in the previous lesson, create it using **[CREATE DATABASE](http://www.postgresql.org/docs/9.4/static/sql-createdatabase.html)**

**bash**

```bash
psql
```

**psql**

```sql
psql (9.4.5)
Type "help" for help.

wdi=# CREATE DATABASE "sql-join-tables";
CREATE DATABASE
wdi=# \c sql-join-tables
You are now connected to database "sql-join-tables" as user "wdi".
sql-join-tables=#
```

------

## Join Tables

### Demonstration

We had `addresses`, `people`, and `cities` tables in the previous lesson - one city was tied to many addresses, and each address was tied to one  (or potentially more) people. In this lesson, `people` and `cities` will be the same; however, now `addresses` will represent the link between a person and a city.

The first step is creating `people` and `cities` just like we did before. Next, we create a new `addresses` table - this time, though, with two columns of foreign keys.

**addresses**

|  id  | people_id | city_id |  no  | street |
| :--: | :-------: | :-----: | :--: | :----: |
|  1   |     5     |    4    | 440  |  10th  |
|  2   |     7     |    2    | 991  |  11th  |
|  3   |     9     |    2    | 406  |  12th  |
|  4   |     5     |    7    | 143  |  13th  |
|  5   |     5     |    7    | 647  |  1st   |

New records can be inserted directly into the `addresses` table, linking together People and Cities. These tables can all be queried using INNER JOIN or using nested SQL queries, much like in the previous examples.

### Code Along : Join Tables

You're all familiar with LinkedIn - let's imagine how a skill endorsement system like LinkedIn's might work.

First, let's create a `skills` table and fill it with data from `data/skills.csv`. Then we'll create an `endorsements` table to connect `skills` to the existing `people` table. Next we'll insert a few `endorsements` connecting `people` to `skills`. Lastly, we'll build and run some queries using the `endorsements` join table.

### Lab : Join Tables

Create a `companies` table and fill it with data from `data/companies.csv`. Then make a `jobs` table to connect `companies` to the existing `people` table; the `jobs` table should contain `start_date` and end_date` columns in addition to linking People to Companies.

Next insert some new `jobs` connecting `people` to `companies`.

- Give at least two people non-overlapping jobs at more than one company.
- Have at least two companies employ at least four people.

Lastly, run some queries using the `jobs` join table:

- For at least one company find all the people who currently work there.
- For at least one person find all of the companies they've worked for and order the result by start date.





### Diagram for joins table

![image](https://git.generalassemb.ly/storage/user/3667/files/6eb6872a-9d39-11e7-9a47-fc574d52244d)



###### Additional Resources for SQL Study (optional)

- [Head First Labs SQL Hands On](http://www.headfirstlabs.com/sql_hands_on/)

###### Required Readings for SQL Study

Please _read_ the following from the [PostgreSQL Documentation](http://www.postgresql.org/docs/9.5/static/index.html):

- The [Preface](http://www.postgresql.org/docs/9.5/static/preface.html) excluding [Bug Reporting Guidelines](http://www.postgresql.org/docs/9.5/static/bug-reporting.html).
- In Part I. [Tutorial](http://www.postgresql.org/docs/9.5/static/tutorial.html)
  - Chapter 1. [Getting Started](http://www.postgresql.org/docs/9.5/static/tutorial-start.html)
  - Chapter 2. [The SQL Language](http://www.postgresql.org/docs/9.5/static/tutorial-sql.html).

You are not expected to create tutorial files as described in [2.1. Introduction](http://www.postgresql.org/docs/9.5/static/tutorial-sql-intro.html).

###### _My Sources for SQL Study:_

- PostgreSQL documentation site including: 
  - *Create and Drop a database: https://www.postgresql.org/docs/9.5/static/tutorial-createdb.html*
  - *Create and Remove a Table: https://www.postgresql.org/docs/9.5/static/tutorial-table.html*

###### PostgreSQL documentation

- [Table basics](https://www.postgresql.org/docs/9.6/static/ddl-basics.html)
  \- a brief overview of tables in an RDBMS.
- [Data Types](https://www.postgresql.org/docs/9.6/static/datatype.html)
  \- the data types available in PostgreSQL.
- [CREATE TABLE](https://www.postgresql.org/docs/9.6/static/sql-createtable.html)
  \- detailed documentation of PostgreSQL's version of the SQL `CREATE TABLE` command.
- [DROP TABLE](https://www.postgresql.org/docs/9.6/static/sql-droptable.html)
  \- detailed documentation of PostgreSQL's version of the SQL `DROP TABLE` command.
  Note well, `DROP TABLE` is unrecoverable if it executes successfully.
- [Queries](https://www.postgresql.org/docs/9.6/static/queries.html) - TOC of the Queries section of PostgreSQL's documentation for `The SQL Language`.
- [Inserting Data](https://www.postgresql.org/docs/9.6/static/dml-insert.html)
  \- overview of adding rows to a table.
- [INSERT](https://www.postgresql.org/docs/9.6/static/sql-insert.html)
  \- detailed documentation of PostgreSQL's version of the SQL `INSERT INTO`
  command.
- [Deleting Data](https://www.postgresql.org/docs/9.6/static/dml-delete.html)
  \- overview of removing rows from a table
- [DELETE](https://www.postgresql.org/docs/9.6/static/sql-delete.html) -
  detailed documentation of PostgreSQL's version of the SQL `DELETE` command.
- [TRUNCATE](https://www.postgresql.org/docs/9.6/static/sql-truncate.html) -
  detailed documentation of PostgreSQL's `TRUNCATE` command.
- [Updating Data](https://www.postgresql.org/docs/9.6/static/dml-update.html)
  \- overview of changing rows
- [UPDATE](https://www.postgresql.org/docs/9.6/static/sql-update.html) -
  detailed documentation of PostgreSQL's version of the SQL `UPDATE` command.
- [Modifying Tables](https://www.postgresql.org/docs/9.6/static/ddl-alter.html)
  \- overview of changing tables.
- [ALTER TABLE](https://www.postgresql.org/docs/9.6/static/sql-altertable.html)
  \- detailed documentation of PostgreSQL's version of the SQL `ALTER TABLE` command.



###### Additional Resources for Intro to Relational DBs

- [SQL Wikipedia article](https://en.wikipedia.org/wiki/SQL)
- [Books.csv source] (https://en.wikipedia.org/wiki/List_of_best-selling_books#List_of_best-selling_single-volume_books)

###### Additional Resources for Intro to Postgres Foreign Keys

- [Constraints](http://www.postgresql.org/docs/9.6/static/ddl-constraints.html) -
   An overview of the variety of constraints that PostgreSQL provides.
- [CREATE TABLE](http://www.postgresql.org/docs/9.6/static/sql-createtable.html) -
   detailed documentation of PostgreSQL's version of
   the SQL `CREATE TABLE` command.
- [ALTER TABLE](http://www.postgresql.org/docs/9.6/static/sql-altertable.html) -
   detailed documentation of PostgreSQL's version of the
   SQL `ALTER TABLE` command.
- [Index Introduction](http://www.postgresql.org/docs/9.6/static/indexes-intro.html) -
   The introductory section of the chapter on indexes in PostgreSQL.
- [CREATE INDEX](http://www.postgresql.org/docs/9.6/static/sql-createindex.html) -
   detailed documentation of PostgreSQL's version of the
    SQL `CREATE INDEX` command.
- [UPDATE](http://www.postgresql.org/docs/9.6/static/sql-update.html) -
   detailed documentation of PostgreSQL's version of the SQL `UPDATE` command.
- [INSERT](http://www.postgresql.org/docs/9.6/static/sql-insert.html) -
   detailed documentation of PostgreSQL's version of the
    SQL `INSERT INTO` command.
- [Joins Between Tables](http://www.postgresql.org/docs/9.6/static/tutorial-join.html) -
   An introduction to querying multiple tables
- [SELECT](http://www.postgresql.org/docs/9.6/static/sql-select.html) -
   detailed documentation of PostgreSQL's version of the SQL `SELECT` command.

## References for PostgreSQL

- [Constraints](http://www.postgresql.org/docs/9.4/static/ddl-constraints.html) -
   An overview of the variety of constraints that PostgreSQL provides.
- [CREATE TABLE](http://www.postgresql.org/docs/9.4/static/sql-createtable.html) -
   detailed documentation of PostgreSQL's version of  the SQL `CREATE TABLE` command.
- [ALTER TABLE](http://www.postgresql.org/docs/9.4/static/sql-altertable.html) -
   detailed documentation of PostgreSQL's version of the  SQL `ALTER TABLE` command.
- [Index Introduction](http://www.postgresql.org/docs/9.4/static/indexes-intro.html) -
   The introductory section of the chapter on indexes in PostgreSQL.
- [CREATE INDEX](http://www.postgresql.org/docs/9.4/static/sql-createindex.html) -
   detailed documentation of PostgreSQL's version of the  SQL `CREATE INDEX` command.
- [UPDATE](http://www.postgresql.org/docs/9.4/static/sql-update.html) -
   detailed documentation of PostgreSQL's version of the SQL `UPDATE` command.
- [INSERT](http://www.postgresql.org/docs/9.4/static/sql-insert.html) -
   detailed documentation of PostgreSQL's version of the  SQL `INSERT INTO` command.
- [Joins Between Tables](http://www.postgresql.org/docs/9.4/static/tutorial-join.html) -
   An introduction to querying multiple tables
- [SELECT](http://www.postgresql.org/docs/9.4/static/sql-select.html) -
   detailed documentation of PostgreSQL's version of the SQL `SELECT` command.

###### Additional Resources for Many-to-Many Relationships in Postgres

- [Constraints](http://www.postgresql.org/docs/9.6/static/ddl-constraints.html) -
   An overview of the variety of constraints that PostgreSQL provides.
- [CREATE TABLE](http://www.postgresql.org/docs/9.6/static/sql-createtable.html) -
   detailed documentation of PostgreSQL's version of the SQL `CREATE TABLE` command.
- [ALTER TABLE](http://www.postgresql.org/docs/9.6/static/sql-altertable.html) -
   detailed documentation of PostgreSQL's version of the SQL `ALTER TABLE` command.
- [Index Introduction](http://www.postgresql.org/docs/9.6/static/indexes-intro.html) -
   The introductory section of the chapter on indexes in PostgreSQL.
- [CREATE INDEX](http://www.postgresql.org/docs/9.6/static/sql-createindex.html) -
   detailed documentation of PostgreSQL's version of the  SQL `CREATE INDEX` command.
- [UPDATE](http://www.postgresql.org/docs/9.6/static/sql-update.html) -
   detailed documentation of PostgreSQL's version of the SQL `UPDATE` command.
- [INSERT](http://www.postgresql.org/docs/9.6/static/sql-insert.html) -
   detailed documentation of PostgreSQL's version of the  SQL `INSERT INTO` command.
- [Joins Between Tables](http://www.postgresql.org/docs/9.6/static/tutorial-join.html) -
   An introduction to querying multiple tables
- [SELECT](http://www.postgresql.org/docs/9.6/static/sql-select.html) -
   detailed documentation of PostgreSQL's version of the SQL `SELECT` command.



