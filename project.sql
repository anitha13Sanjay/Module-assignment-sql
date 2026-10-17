create database project_db;
use project_db;
create table learners(learner_id int  primary key,
Full_name varchar(40),
Country varchar(50));


create table courses(course_id int primary key,
course_name varchar(40) not null,
category varchar(50) ,
unit_price decimal(10,2));

create table purchases(purchase_id int primary key,
learner_id int,
course_id int,
foreign key (learner_id)
references learners(learner_id),
foreign key(course_id)
references courses(course_id),
Quantity int default 0,
purchase_date date);

## insertion for learner table
INSERT INTO learners (learner_id, Full_name, Country)
VALUES
(11, 'Arun Kumar', 'India'),
(12, 'Priya Devi', 'Singapore'),
(13, 'Karthik Raj', 'India'),
(14, 'Divya Sri', 'Malaysia'),
(15, 'Rahul Kumar', 'Australia');
## course table
INSERT INTO courses
(course_id, course_name, category, unit_price)
VALUES
(101, 'Python Programming', 'Programming', 25000.00),
(102, 'SQL for Beginners', 'Database', 18000.00),
(103, 'Power BI', 'Data Analytics', 30000.00),
(104, 'Excel Basics', 'Office Tools', 12000.00),
(105, 'Machine Learning', 'Artificial Intelligence', 45000.00);
## purchase table
INSERT INTO purchases
(purchase_id, learner_id, course_id, Quantity, purchase_date)
VALUES
(301, 11, 101, 1, '2026-07-01'),
(302, 12, 102, 1, '2026-09-03'),
(303, 13, 103, 2, '2026-05-05'),
(304, 11, 104, 1, '2026-04-07'),
(305, 14, 105, 1, '2026-08-10'),
(306, 15, 101, 2, '2026-09-12'),
(307, 12, 103, 1, '2026-10-15'),
(308, 13, 102, 1, '2026-03-18');

select * from learners;

select * from courses;
select * from purchases;
use project_db;

select * from learners;
select * from purchases;

select course_name ,
unit_price  as format_currency 
from courses;

use project_db;




SELECT
    c.course_name AS course_name,
    ROUND(SUM(p.Quantity * c.unit_price), 2) AS total_revenue
FROM courses AS c
JOIN purchases AS p
    ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_revenue DESC;

SELECT
    l.full_name AS learner_name,
    ROUND(SUM(p.Quantity * c.unit_price), 2) AS total_spent
FROM learners AS l
JOIN purchases AS p
    ON l.learner_id = p.learner_id
JOIN courses AS c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name
ORDER BY total_spent DESc;


 select   l.learner_id AS learner_id,
    l.full_name AS learner_name,
    c.course_name AS course_name,
    p.Quantity AS quantity,
    ROUND(p.Quantity * c.unit_price, 2) AS total_amount
FROM learners AS l
INNER JOIN purchases AS p
    ON l.learner_id = p.learner_id
INNER JOIN courses AS c
    ON p.course_id = c.course_id
ORDER BY total_amount DESC;

select
c.course_name,c.category,p.quantity,c.unit_price total_amount,
p.purchase_date
from learners l
inner join purchases p on l.learner_id=p.learner_id
inner join courses c on p.course_id=c.course_id;




select   l.full_name, l.Country,
    SUM(p.Quantity * c.unit_price) total_spending
FROM learners l, purchases p, courses c
WHERE l.learner_id = p.learner_id
AND p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.Country
ORDER BY total_spending DESC;


    
select   c.course_name,   SUM(p.Quantity) total_quantity
FROM courses c, purchases p
WHERE c.course_id = p.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_quantity DESC
LIMIT 3;
 
 
 use project_db;
SELECT l.full_name
FROM learners l, purchases p, courses c
GROUP BY l.learner_id, l.full_name
HAVING COUNT(DISTINCT c.category) > 1;




SELECT c.course_name
FROM courses c
LEFT JOIN purchases p
ON c.course_id = p.course_id
WHERE p.course_id IS NULL;







