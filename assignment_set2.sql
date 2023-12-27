## create database 
create database assign2;

##specify the db 
use assign2;

## create table 

create table skills(
id int,
technology varchar(50)
);

## insert values

INSERT INTO skills VALUES
(1, 'DS'),
(1, 'Tableau'),
(1, 'SQL'),
(2, 'R'),
(2, 'Power BI'),
(1, 'Python');

select * from skills;

## question list the candidate those possess all req skills

SELECT DISTINCT id
FROM skills
WHERE technology IN ('Python', 'Tableau', 'SQL', 'DS');


##question ids of the product info that have 0 likes

use assign2;

## create table 

create table product_info(
prod_id int,
product varchar(50)
);

## 

insert into product_info values
(1001, 'blog'),
(1002, 'youtube'),
(1003, 'education');


##
select * from product_info;


## table 2
USE assign2;

-- Create the prod_info_likes table
CREATE TABLE prod_info_likes (
    user_id INT,
    prod_id INT,
    liked_date DATE
);

-- Insert sample data into prod_info_likes
INSERT INTO prod_info_likes VALUES
(1, 1001, '2023-08-19'),
(2, 1003, '2023-08-18');

-- Select data from prod_info_likes
SELECT * FROM prod_info_likes;





## query



SELECT pi.prod_id
FROM product_info pi
LEFT JOIN prod_info_likes pl ON pi.prod_id = pl.prod_id
WHERE pl.prod_id IS NULL;


