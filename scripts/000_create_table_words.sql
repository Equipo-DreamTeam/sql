-- create a table to store information about medical words
-- To run the script from the terminal:  psql <db-name> --file=<path-to-file>
-- To run the script from inside psql:   \i <file>.
CREATE TABLE words(id SERIAL PRIMARY KEY, grouping_english TEXT, english TEXT, grouping_spanish TEXT, spanish TEXT, description_english TEXT, description_spanish TEXT);