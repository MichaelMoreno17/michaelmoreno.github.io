# DROP DATABASE IF EXISTS ig2_clone;
# CREATE DATABASE ig2_clone;
# USE ig2_clone; 

# CREATE TABLE users (
#     id INTEGER AUTO_INCREMENT PRIMARY KEY,
#     username VARCHAR(255) UNIQUE NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW()
# );

# CREATE TABLE photos (
#     id INTEGER AUTO_INCREMENT PRIMARY KEY,
#     image_url VARCHAR(255) NOT NULL,
#     user_id INTEGER NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW(),
#     FOREIGN KEY(user_id) REFERENCES users(id)
# );

# CREATE TABLE comments (
#     id INTEGER AUTO_INCREMENT PRIMARY KEY,
#     comment_text VARCHAR(255) NOT NULL,
#     photo_id INTEGER NOT NULL,
#     user_id INTEGER NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW(),
#     FOREIGN KEY(photo_id) REFERENCES photos(id),
#     FOREIGN KEY(user_id) REFERENCES users(id)
# );

# CREATE TABLE likes (
#     user_id INTEGER NOT NULL,
#     photo_id INTEGER NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW(),
#     FOREIGN KEY(user_id) REFERENCES users(id),
#     FOREIGN KEY(photo_id) REFERENCES photos(id),
#     PRIMARY KEY(user_id, photo_id)
# );

# CREATE TABLE follows (
#     follower_id INTEGER NOT NULL,
#     followee_id INTEGER NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW(),
#     FOREIGN KEY(follower_id) REFERENCES users(id),
#     FOREIGN KEY(followee_id) REFERENCES users(id),
#     PRIMARY KEY(follower_id, followee_id)
# );

# CREATE TABLE tags (
#   id INTEGER AUTO_INCREMENT PRIMARY KEY,
#   tag_name VARCHAR(255) UNIQUE,
#   created_at TIMESTAMP DEFAULT NOW()
# );

# CREATE TABLE photo_tags (
#     photo_id INTEGER NOT NULL,
#     tag_id INTEGER NOT NULL,
#     FOREIGN KEY(photo_id) REFERENCES photos(id),
#     FOREIGN KEY(tag_id) REFERENCES tags(id),
#     PRIMARY KEY(photo_id, tag_id)
# );


SELECT username, created_at, id FROM users
ORDER BY creaed_at LIMIT 5;

SELECT DATE_FORMAT(created_at, '%W') AS 'day of the week',
COUNT(DATE_FORMAT(created_at, '%W')) AS 'number of registration'
FROM users
GROUP BY DATE_FORMAT(created_at, '%W')
ORDER BY 'number of registration' DESC;

SELECT DATE_FORMAT(created_at, '%W') AS 'day of the week',
COUNT(DATE_FORMAT(created_at, '%W')) AS 'number of registration'
FROM users
GROUP BY DATE_FORMAT(created_at, '%W')
ORDER BY 'number of registration' DESC;


# SELECT username,
#     CASE
#         WHEN image_url IS TRUE THEN 'active'   
#         ELSE 'inactive'
#         END AS 'activity'
# FROM users
# LEFT JOIN photos 
#     ON users.id = photos.user_id
# ORDER BY 'activity' DESC;

SELECT
    username,
    IFNULL(image_url, 'inactive') 
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

SELECT
    username,
    COUNT(likes.created_at) AS 'total likes'
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY username
ORDER BY COUNT(likes.created_at) DESC
LIMIT 10;

SELECT 
    username,
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

SELECT 
    username,
    COUNT(photos.user_id)
FROM users
INNER JOIN photos
    ON photos.user_id = users.id
GROUP BY users.id;
    
SELECT
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

SELECT 
tags.tag_name,
COUNT(photo_tags.tag_id) AS total
FROM tags 
INNER JOIN photo_tags    
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id 
ORDER BY total DESC LIMIT 5; 


SELECT
    username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);



























