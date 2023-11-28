## creating table
use assignment;
CREATE TABLE City_table (
    id INT NOT NULL,
	name VARCHAR(17),
    countrycode VARCHAR(3),
    district varchar(20),
    population int
  );
select * from City_table;


#City-Dataset:https://docs.google.com/spreadsheets/d/1dk9kRwcMxj5USuJqxtITD05S-aOUD6fzNzV W41dcpgc/edit?usp=sharing

#Q1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
#The CITY table is described as follows:


SELECT * FROM city_table
WHERE CountryCode = 'USA' AND Population > 100000;



#Q2. Query the NAME ﬁeld for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
#The CITY table is described as follows:
SELECT NAME
FROM City_table
WHERE CountryCode = 'USA' AND Population > 120000;
City_table


#Q3. Query all columns (attributes) for every row in the CITY table. The CITY table is described as follows:
SELECT *
FROM city_table;

#Q4. Query all columns for a city in CITY with the ID 1661. The CITY table is described as follows:
SELECT * FROM city_table
WHERE ID = 1661;

#Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city_table
where countrycode ="JPN";

#Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select  name  from city_table
where countrycode="JPN";


use assignment;
create table station_table(
id int not null,
city varchar(21),
state varchar(2),
lat_n int,
long_w int
);

select * from station_table;
#Q7. Query a list of CITY and STATE from the STATION table. The STATION table is described as follows:

SELECT city, State
FROM station_table;


desc station_table


# Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

SELECT DISTINCT city,id
FROM station_table
WHERE ID % 2 = 0;




#Q9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
#SELECT (SELECT COUNT(CITY) FROM STATION_TABLE) - (SELECT COUNT(DISTINCT CITY) FROM STATION_TABLE) AS difference;

SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS difference
FROM STATION_TABLE;


##Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes ﬁrst when ordered alphabetically.

SELECT CITY, LENGTH(CITY) AS name_length_shortest
FROM STATION_TABLE
ORDER BY name_length_shortest ASC, CITY ASC
LIMIT 1; ##This limits the result to only one row, which corresponds to the city with the shortest name.

SELECT CITY, LENGTH(CITY) AS name_length_longest
FROM STATION_TABLE
ORDER BY name_length_longest DESC, CITY DESC
LIMIT 1;

#Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION_TABLE 
WHERE CITY REGEXP '^[aeiouAEIOU]'; ##regular expression '^[aeiouAEIOU]' matches CITY names that start with any lowercase or uppercase vowel.



##Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION_table
WHERE CITY REGEXP '[aeiouAEIOU]$'; ##The regular expression [aeiouAEIOU]$ matches CITY names that end with any lowercase or uppercase vowel.

#Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION_TABLE
WHERE CITY REGEXP '^[^aeiouAEIOU]';##The regular expression '^[^aeiouAEIOU]' matches CITY names that do not start with any lowercase or uppercase vowel.


#Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION_TABLE
WHERE CITY REGEXP '[^aeiouAEIOU]$'; ##The regular expression [^aeiouAEIOU]$ matches CITY names that do not end with any lowercase or uppercase vowel.


#Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION_TABLE
WHERE CITY REGEXP '^[^aeiouAEIOU]' OR CITY REGEXP '[^aeiouAEIOU]$';



#Q18.

#Table: Views


CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

INSERT INTO Views (article_id, author_id, viewer_id, view_date)
VALUES
    (1, 3, 5, '2019-08-01'),
    (1, 3, 6, '2019-08-02'),
    (2, 7, 7, '2019-08-01'),
    (2, 7, 6, '2019-08-02'),
    (4, 7, 1, '2019-07-22'),
    (3, 4, 4, '2019-07-21'),
    (3, 4, 4, '2019-07-21');

select * from Views;

select distinct author_id as id from Views  where author_id = viewer_id order by
author_id asc;


##Q19 If the customer's preferred delivery date is the same as the order date, then the order is called immediately; otherwise, it is called scheduled.
##Write an SQL query to ﬁnd the percentage of immediate orders in the table, rounded to 2 decimal places.


use assignment;
CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');

select * from Delivery;


SELECT 
    ROUND(
        (SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*)) * 100, 
        2
    ) AS immediate_percentage
FROM Delivery;






###Q20.A company is running Ads and wants to calculate the performance of each Ad. Performance of the Ad is measured using Click-Through Rate (CTR) where:
use assignment;
CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
);

INSERT INTO Ads (ad_id, user_id, action)
VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');
    
select * from ads;


SELECT
    ad_id,
    ROUND(
        SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) /
        (COUNT(*) - SUM(CASE WHEN action = 'Ignored' THEN 1 ELSE 0 END)) * 100,
        2
    ) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;



##Q21 Write an SQL query to ﬁnd the team size of each of the employees. Return result table in any order.
use assignment;
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    team_id INT
);


INSERT INTO Employee (employee_id, team_id) VALUES
    (1, 8),
    (2, 8),
    (3, 8),
    (4, 7),
    (5, 9),
    (6, 9);
    
select * from employee;
SELECT
    employee_id,
    COUNT(*) OVER (PARTITION BY team_id) AS team_size
FROM Employee order by employee_id;

###PARTITION BY team_id: This clause tells the window function to create separate partitions (groups) for each unique team_id. This means that for each row in the result set, it counts the number of employees who belong to the same team as the current row's employee.


##Q22 Write an SQL query to ﬁnd the type of weather in each country for November 2019. The type of weather is:
#●	Cold if the average weather_state is less than or equal 15,
#●	Hot if the average weather_state is greater than or equal to 25, and
#●	Warm otherwise. 

use assignment;
CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255)
);

INSERT INTO Countries (country_id, country_name) VALUES
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');
    
select * from Countries;

use assignment;
CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE,
    PRIMARY KEY (country_id, day)
);

-- Insert data into the Weather table
INSERT INTO Weather (country_id, weather_state, day) VALUES
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');


select * from weather;


select c.country_name, case
when avg(weather_state) <= 15 then 'Cold'
when avg(weather_state) >= 25 then 'Hot'
else 'Warm'
end as weather_state
from
countries c
left join ##It matches countries with their corresponding weather data, and it includes all countries, even if they have no matching weather data.
weather w
on c.country_id = w.country_id
where month(day) = 11
group by c.country_name;



##23 rite an SQL query to ﬁnd the average selling price for each product. average_price should be rounded to 2 decimal places.
#Return the result table in any order.

use assignment;

-- Create Prices table
CREATE TABLE Price1(
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

-- Insert data into Prices table
INSERT INTO Price1 (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);
select * from Price1;

use assignment;
-- Create UnitsSold1 table
CREATE TABLE UnitsSold1 (
    product_id INT,
    purchase_date DATE,
    units INT
);

-- Insert data into UnitsSold table
INSERT INTO UnitsSold1 (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);
select * from UnitsSold1;

SELECT
    p.product_id,
    ROUND(SUM(u.units * p.price) / SUM(u.units), 2) AS average_price
FROM
    prices p
LEFT JOIN
    unitssold u ON p.product_id = u.product_id
              AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    p.product_id;
    
##24 Write an SQL query to report the ﬁrst login date for each player. 
use assignment;
-- Create Activity table
CREATE TABLE Activity1 (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

-- Insert data into Activity table
INSERT INTO Activity1 (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
select * from Activity1;

SELECT
    player_id,
    MIN(event_date) AS first_login_date
FROM
    Activity
GROUP BY
    player_id;

##Q 25 Write an SQL query to report the device that is ﬁrst logged in for each player. 
select t.player_id, t.device_id
from (select player_id, device_id, row_number() over(partition by player_id
order by event_date) as num from activity)t
where t.num = 1;

## 26 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
use assignment;
CREATE TABLE Product3 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);
INSERT INTO Product3 (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
    (3, 'HP', 'Laptop'),
    (4, 'Lenovo', 'Laptop'),
    (5, 'Leetcode Kit', 'T-shirt');

select * from Product3 ;



CREATE TABLE Order3 (
    product_id INT,
    order_date DATE,
    unit INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order3 (product_id, order_date, unit)
VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);

select * from Order3;

select p.product_name, sum(o.unit) as unit
from
Products p
left join
Orders o
on p.product_id = o.product_id
where month(o.order_date) = 2 and year(o.order_date) = 2020
group by p.product_name
having unit >= 100

#27 
use assignment;
CREATE TABLE User3 (
    user_id INT PRIMARY KEY,
    name VARCHAR(255),
    mail VARCHAR(255)
);

INSERT INTO User3 (user_id, name, mail) VALUES
(1, 'Winston', 'winston@leetcode.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@leetcode.com'),
(4, 'Sally', 'sally.come@leetcode.com'),
(5, 'Marwan', 'quarz#2020@leetcode.com'),
(6, 'David', 'david69@gmail.com'),
(7, 'Shapiro', '.shapo@leetcode.com');

select * from User3

use assignment;
SELECT user_id, name, mail
FROM User3
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';


##27 Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
use assignment;
CREATE TABLE Customers1 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    country VARCHAR(255)
);
use assignment;
CREATE TABLE Product4 (
    product_id INT PRIMARY KEY,
    description VARCHAR(255),
    price INT
);
use assignment;
CREATE TABLE Orders4 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT INTO Customers1 (customer_id, name, country) VALUES
(1, 'Winston', 'USA'),
(2, 'Jonathan', 'Peru'),
(3, 'Moustafa', 'Egypt');

INSERT INTO Product4 (product_id, description, price) VALUES
(10, 'LC Phone', 300),
(20, 'LC T-Shirt', 10),
(30, 'LC Book', 45),
(40, 'LC Keychain', 2);

INSERT INTO Orders4 (order_id, customer_id, product_id, order_date, quantity) VALUES
(1, 1, 10, '2020-06-10', 1),
(2, 1, 20, '2020-07-01', 1),
(3, 1, 30, '2020-07-08', 2),
(4, 2, 10, '2020-06-15', 2),
(5, 2, 40, '2020-07-01', 10),
(6, 3, 20, '2020-06-24', 2),
(7, 3, 30, '2020-06-25', 2),
(9, 3, 30, '2020-05-08', 3);

select * from customers1;
select * from product4;
select * from orders4;







##29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. Return the result table in any order


use assignment;
-- Create TVProgram table
CREATE TABLE TVProgram1 (
    program_date DATE,
    content_id INT,
    channel VARCHAR(255),
    PRIMARY KEY (program_date, content_id)
);

-- Insert data into TVProgram table
INSERT INTO TVProgram1 (program_date, content_id, channel) VALUES
('2020-06-10', 1, 'LC-Channel'),
('2020-05-11', 2, 'LC-Channel'),
('2020-05-12', 3, 'LC-Channel'),
('2020-05-13', 4, 'Disney Ch'),
('2020-06-18', 4, 'Disney Ch'),
('2020-07-15', 5, 'Disney Ch');

use assignment;
select * from TVProgram1;
CREATE TABLE Content1 (
    content_id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    Kids_content ENUM('Y', 'N'),
    content_type VARCHAR(255)
);

-- Insert data into Content table
INSERT INTO Content1 (content_id, title, Kids_content, content_type) VALUES
('1', 'Leetcode Movie', 'N', 'Movies'),
('2', 'Alg. for Kids', 'Y', 'Series'),
('3', 'Database Sols', 'N', 'Series'),
('4', 'Aladdin', 'Y', 'Movies'),
('5', 'Cinderella', 'Y', 'Movies');

select * from Content1;

SELECT DISTINCT Content1.title
FROM Content1
RIGHT JOIN TVProgram1 ON Content1.content_id = TVProgram1.content_id
WHERE Content1.Kids_content = 'Y'
    AND Content1.content_type = 'Movies'
    AND (MONTH(TVProgram1.program_date) = 6 AND YEAR(TVProgram1.program_date) = 2020);


##30
use assignment;

CREATE TABLE NPV1 (
    id INT,
    year INT,
    npv INT,
    PRIMARY KEY (id, year)
);
use assignment;
CREATE TABLE Queries1 (
    id INT,
    year INT,
    PRIMARY KEY (id, year)
);

INSERT INTO NPV1 (id, year, npv) VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

INSERT INTO Queries1 (id, year) VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

select * from NPV1 ;


select * from Queries1;

SELECT q.id, q.year, n.npv
FROM Queries q
LEFT JOIN NPV n ON q.id = n.id AND q.year = n.year;

SELECT q.id, q.year, n.npv
FROM NPV n
RIGHT JOIN Queries q ON q.id = n.id AND q.year = n.year;

##32 Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
use assignment;
-- Create Employees table
CREATE TABLE Employees3 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert data into Employees table
INSERT INTO Employees3 (id, name) VALUES
(1, 'Alice'),
(7, 'Bob'),
(11, 'Meir'),
(90, 'Winston'),
(3, 'Jonathan');

select * from Employees3;
use assignment;
-- Create EmployeeUNI1 table
CREATE TABLE EmployeeUNI1 (
    id INT PRIMARY KEY,
    unique_id INT
);

-- Insert data into EmployeeUNI table
INSERT INTO EmployeeUNI1 (id, unique_id) VALUES
(3, 1),
(11, 2),
(90, 3);
select * from  EmployeeUNI1 ;

SELECT E.name, EU.unique_id
FROM Employees E
LEFT JOIN EmployeeUNI EU ON E.id = EU.id;


##33 Write an SQL query to report the distance travelled by each user.
#Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.

use assignment;
##Create Users table
CREATE TABLE User4 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert data into Users table
INSERT INTO User4 (id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Alex'),
(4, 'Donald'),
(7, 'Lee'),
(13, 'Jonathan'),
(19, 'Elvis');


select * from User4;
-- Create Rides table

use assignment;
CREATE TABLE Rides1 (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT
);

-- Insert data into Rides table
INSERT INTO Rides (id, user_id, distance) VALUES
(1, 1, 120),
(2, 2, 317),
(3, 3, 222),
(4, 7, 100),
(5, 13, 312),
(6, 19, 50),
(7, 7, 120),
(8, 19, 400),
(9, 7, 230);
select * from Rides1;



SELECT
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM
    users u
LEFT JOIN
    rides r ON u.id = r.user_id
GROUP BY
    u.name
ORDER BY
    travelled_distance DESC,
    u.name ASC;


SELECT
    u.name,
    COALESCE(SUM(r.distance), 0) AS travelled_distance
FROM
    user4 u
LEFT JOIN
    rides r ON u.id = r.user_id
GROUP BY
    u.name
ORDER BY
    travelled_distance DESC,
    u.name ASC;
#describe user4



## 35

use assignment;
-- Create Movies table
CREATE TABLE Movie1 (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255)
);

-- Insert data into Movies table
INSERT INTO Movie1 VALUES
(1, 'Avengers'),
(2, 'Frozen 2'),
(3, 'Joker');


select * from movie1;

use assignment;
-- Create Users table
CREATE TABLE User5 (
    user_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert data into Users table
INSERT INTO User5 VALUES
(1, 'Daniel'),
(2, 'Monica'),
(3, 'Maria'),
(4, 'James');


select * from User5;

use assignment;
-- Create MovieRating table
-- Create MovieRating table
CREATE TABLE MovieRating1 (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE,
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES Movie1(movie_id),
    FOREIGN KEY (user_id) REFERENCES User5(user_id)
);


-- Insert data into MovieRating table
INSERT INTO MovieRating1 VALUES
(1, 1, 3, '2020-01-12'),
(1, 2, 4, '2020-02-11'),
(1, 3, 2, '2020-02-12'),
(1, 4, 1, '2020-01-01'),
(2, 1, 5, '2020-02-17'),
(2, 2, 2, '2020-02-01'),
(2, 3, 2, '2020-03-01'),
(3, 1, 3, '2020-02-22'),
(3, 2, 4, '2020-02-25');

select * from movierating1;
-- Write an SQL query to:
-- ●Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- ●Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
-- Find the name of the user who has rated the greatest number of movies.
-- Find the user who has rated the greatest number of movies.
SELECT name AS Results
FROM User5
WHERE user_id = (
    SELECT user_id
    FROM (
        SELECT u.user_id, COUNT(m.movie_id) AS movies_rated
        FROM User5 u
        LEFT JOIN MovieRating1 m ON u.user_id = m.user_id
        GROUP BY u.user_id
        ORDER BY movies_rated DESC, u.name
        LIMIT 1
    ) AS subquery1
)
UNION
-- Find the movie name with the highest average rating in February 2020.
SELECT title AS Results
FROM Movie1
WHERE movie_id = (
    SELECT movie_id
    FROM (
        SELECT movie_id, AVG(rating) AS avg_rating
        FROM MovieRating1
        WHERE MONTH(created_at) = 2 AND YEAR(created_at) = 2020
        GROUP BY movie_id
        ORDER BY avg_rating DESC, title
        LIMIT 1
    ) AS subquery2
);

##36 same as 33


##37 same as 32


##38

use assignment;
-- Create Departments and Students tables without foreign key
CREATE TABLE Department1 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);
use assignment;
CREATE TABLE Student1 (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department_id INT
);

-- Insert sample data into the tables
INSERT INTO Department1 (id, name) VALUES
(1, 'Electrical Engineering'),
(7, 'Computer Engineering'),
(13, 'Business Administration');
select * from Department1;


INSERT INTO Student1 (id, name, department_id) VALUES
(23, 'Alice', 1),
(1, 'Bob', 7),
(5, 'Jennifer', 13),
(2, 'John', 14),
(4, 'Jasmine', 77),
(3, 'Steve', 74),
(6, 'Luis', 1),
(8, 'Jonathan', 7),
(7, 'Daiana', 33),
(11, 'Madelynn', 1);


select * from  Student1;



select id, name from Student1
where department_id not in (select id from Department1);

#WHERE department_id NOT IN (SELECT id FROM Departments): This is the condition for filtering the rows. It selects rows where the
# department_id in the Students table is not found in the result of the subquery.
## where department_id from student shpuld not present in id of table department



##39 Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.

use assignment;
-- Create Calls table
CREATE TABLE Call1 (
    from_id INT,
    to_id INT,
    duration INT
);

-- Insert sample data into the table
INSERT INTO Call1 (from_id, to_id, duration) VALUES
(1, 2, 59),
(2, 1, 11),
(1, 3, 20),
(3, 4, 100),
(3, 4, 200),
(3, 4, 200),
(4, 3, 499);


select * from Call1;


SELECT
    CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1,
    CASE WHEN from_id > to_id THEN from_id ELSE to_id END AS person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2;


## 40 same as 24



##41

use assignment;
-- Create Warehouse table
CREATE TABLE Warehouse1 (
    name VARCHAR(255),
    product_id INT,
    units INT,
    PRIMARY KEY (name, product_id)
);

-- Insert data into Warehouse table
INSERT INTO Warehouse1 (name, product_id, units) VALUES
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);
select * from  Warehouse1;
-- Create Products table

use assignment;
CREATE TABLE Product6 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    Width INT,
    Length INT,
    Height INT
);

-- Insert data into Products table
INSERT INTO Product6 (product_id, product_name, Width, Length, Height) VALUES
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);


select * from Product6 ;

SELECT
    w.name AS warehouse_name,
    SUM(p.Width * p.Length * p.Height) AS total_volume_cubic_feet
FROM
    Warehouse1 w
JOIN
    Product6 p ON w.product_id = p.product_id
GROUP BY
    w.name;
    
##42

use assignment;
-- Create Sales table
CREATE TABLE Sale2 (
    sale_date DATE,
    fruit ENUM ('apples', 'oranges'),
    sold_num INT,
    PRIMARY KEY (sale_date, fruit)
);

-- Insert sample data
INSERT INTO Sale2 (sale_date, fruit, sold_num) VALUES
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);

select * from Sale2;

SELECT
    sale_date,
    (MAX(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END) - MAX(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END)) AS diff
FROM
    Sale2
GROUP BY
    sale_date
ORDER BY
    sale_date;


# 43
#Write an SQL query to report the fraction of players that logged in again on the day after the day they ﬁrst logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their ﬁrst login date, then divide that number by the total number of players.
use assignment;
-- Create Activity table
CREATE TABLE Activity3 (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

-- Insert sample data into the Activity table
INSERT INTO Activity3 (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);


select * from activity3;


#44 Write an SQL query to report the managers with at least ﬁve direct reports. 
use assignment;
-- Create Employee table
CREATE TABLE Employee4(
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

-- Insert sample data into the Employee table
INSERT INTO Employee4 (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);


select t.name from
(select a.id, a.name, count(b.managerID) as no_of_direct_reports from
employee4 a
INNER JOIN
employee4 b
on a.id = b.managerID
group by b.managerID) t
where no_of_direct_reports >= 5
order by t.name;



##45

use assignment;
-- Create Department table
CREATE TABLE Department3 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(255)
);

-- Insert sample data into the Department table
INSERT INTO Department3 (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');


use assignment;
-- Create Student table
-- Create Student2 table
CREATE TABLE Student2 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255),
    gender VARCHAR(1),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department3 (dept_id)
);


-- Insert sample data into the Student table
INSERT INTO Student2 (student_id, student_name, gender, dept_id) VALUES
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);


SELECT dept_name, COUNT(Student2.student_id) AS student_number
FROM Department3
LEFT JOIN Student2 ON Department3.dept_id = Student2.dept_id
GROUP BY Department3.dept_id, Department3.dept_name
ORDER BY student_number DESC, Department3.dept_name;


##46 Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
use assignment;
-- Create Customer table
CREATE TABLE Customer2 (
    customer_id INT,
    product_key INT
);


-- Insert data into Customer table
INSERT INTO Customer2 (customer_id, product_key)
VALUES
    (1, 5),
    (2, 6),
    (3, 5),
    (3, 6),
    (1, 6);
    
select * from  Customer2;


use assignment;
-- Create Product table
CREATE TABLE Product7 (
    product_key INT PRIMARY KEY
);

-- Insert data into Product table
INSERT INTO Product7 (product_key)
VALUES
    (5),
    (6);
select * from Product7;

SELECT customer_id
FROM customer2
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM product7);


##47
use assignment;
CREATE TABLE Employee5 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    experience_years INT
);
-- Insert data into Employee table
INSERT INTO Employee5 (employee_id, name, experience_years) VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);
    
select * from Employee5;

use assignment;
CREATE TABLE Project (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

INSERT INTO Project (project_id, employee_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);
select * from Project;

SELECT t.project_id, t.employee_id
FROM (
    SELECT
        p.project_id,
        e.employee_id,
        DENSE_RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS r
    FROM
        Project p
    LEFT JOIN
        employee5 e ON p.employee_id = e.employee_id
) t
WHERE
    t.r = 1
ORDER BY
    t.project_id;

describe  Employee5;




##48
use assignment;
-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    name VARCHAR(255),
    available_from DATE
);

use assignment;
-- Create Orders table
CREATE TABLE Orders5 (
    order_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    dispatch_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into Books table
INSERT INTO Books (book_id, name, available_from) VALUES
    (1, 'Kalila And Demna', '2010-01-01'),
    (2, '28 Letters', '2012-05-12'),
    (3, 'The Hobbit', '2019-06-10'),
    (4, '13 Reasons Why', '2019-06-01'),
    (5, 'The Hunger Games', '2008-09-21');
select * from books;
-- Insert data into Orders table
INSERT INTO Orders5 (order_id, book_id, quantity, dispatch_date) VALUES
    (1, 1, 2, '2018-07-26'),
    (2, 1, 1, '2018-11-05'),
    (3, 3, 8, '2019-06-11'),
    (4, 4, 6, '2019-06-05'),
    (5, 4, 5, '2019-06-20'),
    (6, 5, 9, '2009-02-02'),
    (7, 5, 8, '2010-04-13');
select * from orders5;



SELECT t1.book_id, t1.name
FROM
(
    SELECT book_id, name
    FROM Books
    WHERE available_from < '2019-05-23'
) t1
LEFT JOIN
(
    SELECT book_id, SUM(quantity) AS quantity
    FROM Orders5
    WHERE dispatch_date > '2018-06-23' AND dispatch_date <= '2019-06-23'
    GROUP BY book_id
    HAVING quantity < 10
) t2
ON t1.book_id = t2.book_id;



##49
