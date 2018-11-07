INSERT INTO groupings(grouping_english,grouping_spanish)
SELECT DISTINCT grouping_english, grouping_spanish
FROM words
ORDER BY grouping_english;