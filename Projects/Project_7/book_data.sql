# USE book_data.sql;

# CREATE TABLE books 
# 	(
# 		book_id INT NOT NULL AUTO_INCREMENT,
# 		title VARCHAR(100),
# 		author_fname VARCHAR(100),
# 		author_lname VARCHAR(100),
# 		released_year INT,
# 		stock_quantity INT,
# 		pages INT,
# 		PRIMARY KEY(book_id)
# 	);

# INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
# VALUES
# ('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
# ('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
# ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
# ('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
# ('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
# ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
# ('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
# ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
# ('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
# ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
# ('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
# ("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
# ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
# ('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
# ('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
# ('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT 
    CONCAT
    (
        SUBSTRING(title,1,20),
        '...'
    ) AS 'short title'
FROM books;

SELECT author_fname AS 'First Name', author_lname AS 'Last Name',
    CONCAT
    (
        author_fname,
        ' ',
        author_lname
    ) AS 'Full Name'
FROM books;

# SELECT 
# 	SUBSTRING
# 	(
# 		REPLACE(title, 'e', '3'),
# 		1,
# 		10
# 	) AS 'pepe steer'
# FROM books;

SELECT
    REPLACE (title, ' ', '->') AS title
FROM books;

SELECT author_lname AS 'forward', REVERSE(author_lname) AS 'backward'
FROM books;

SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM books;

SELECT 
    CONCAT
    (
        title, ' was released in ', released_year
    ) AS 'blub'
FROM books;

SELECT title AS 'title', CHAR_LENGTH(title) AS 'title length'
FROM books;

SELECT CONCAT(SUBSTRING(title,1,10), '...') AS 'short title',CONCAT(author_lname, ',', author_fname) AS 'author', CONCAT(stock_quantity, ' in stock') AS 'quantity'
FROM books;

SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title',
       CONCAT(author_lname, ',', author_fname) AS 'author',
       CONCAT(stock_quantity, ' in stock') AS 'quantity'
FROM books WHERE(title IN ('american gods', 'a heartbreaking work of staggering genius'));

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);


SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;
SELECT DISTINCT author_fname, author_lname FROM books; # this is the same as above but two columns

SELECT title FROM books ORDER BY pages;
SELECT title, author_fname, author_lname FROM books ORDER BY 2 DESC;
SELECT DISTINCT author_fname, author_lname FROM books ORDER BY 1,2 LIMIT 5;

SELECT author_lname, author_fname FROM books WHERE author_fname LIKE 'da%';
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE "____";

#exercises
SELECT title AS title FROM books WHERE title like '%stories';
SELECT title AS title, pages AS pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(title,' - ', released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %'; 
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;
SELECT title, author_lname FROM books ORDER BY 2,1;
SELECT UPPER(CONCAT('my favorite author is ', author_fname, author_lname, '!')) AS yell FROM books ORDER BY author_lname;

#AGGREGATE FUNCTIONS
SELECT COUNT(*) FROM books;
SELECT COUNT(DISTINCT author_lname, author_fname) FROM books;
SELECT COUNT(title) FROM books WHERE title LIKE '%the%';
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS book_release FROM books GROUP BY released_year;

SELECT MIN(released_year) 
FROM books;
 
SELECT MIN(released_year) FROM books;
 
SELECT MIN(pages) FROM books;
 
SELECT MAX(pages) 
FROM books;
 
SELECT MAX(released_year) 
FROM books;
 
SELECT MAX(pages), title
FROM books;
#FIRST USE OF A SUBUERY 
SELECT title, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
                                   #OR 
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

#EXERCISES
SELECT COUNT(*) FROM books;
SELECT released_year, COUNT(released_year) AS 'number released' FROM books GROUP BY released_year;
SELECT SUM(stock_quantity) FROM books;
SELECT CONCAT(author_lname, ' ', author_fname), AVG(released_year) FROM books GROUP BY author_lname, author_fname;
SELECT CONCAT(author_fname, ' ', author_lname), pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT released_year AS 'years', COUNT(released_year) AS '# released', AVG(pages) AS 'average pages' FROM books GROUP BY released_year;


SELECT * FROM books WHERE released_year < 1980;
SELECT * FROM books WHERE author_lname IN('eggers', 'chabon');
SELECT * FROM books WHERE author_lname = 'lahiri' AND released_year >= 2000;
SELECT * FROM books WHERE pages BETWEEN 100 AND 200;
SELECT * FROM books WHERE author_lname LIKE 'c%' OR author_lname LIKE 's%';
SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'short stories'
        WHEN title = 'just kids' OR title = 'a heartbreaking work of staggering genius' THEN 'memoir'
        ELSE 'novel' 
        END AS 'type'
FROM books;
































































