use orders;


 select*from city;



select*from od;
select distinct product from od;

select count(*) as total_order
from od;


select sum(amt) as total_orders_revenue
from od;


select product,count(*) as total_orders 
from od
group by product
order by total_orders desc ;

select product , sum(amt) as total_amount ,count(*)  as total_orders from od
group by product 
order by total_orders desc;


select year(order_date) from od;


select month(order_date),sum(amt) as total_revenue
from od
group by month(order_date)
order by month(order_date) ;


select year(order_date) ,sum(amt) as total_revenue
from od
group by year(order_date);





SELECT MONTH(order_date), COUNT(*)
FROM od
GROUP BY MONTH(order_date)
order by month(order_date) desc;


SELECT MONTHNAME(order_date) as  months, round(sum(amt),0)  as avaragesale
FROM od
GROUP BY MONTH(order_date), monthname(order_date)
order by  month(order_date);



select * from od
where product in ('Laptop','mouse');


select * from od
where amt between 30000 and 60000;



select * from od
where name like 'A%';


SELECT *
from od
WHERE name LIKE 'A___';

SELECT *
FROM od
WHERE amt>(
SELECT AVG(amt)
FROM od
);
SELECT CURRENT_DATE;


select name, amt from od 
order by  amt desc limit 5;


  with ctc as(
  select id , name , amt  from 
od
order by  amt desc limit 5

)
  
  select order_date.o from  od c
  join ctc c
  on o.id=c.id;
  
  
  WITH ctc AS (
    SELECT id, name, amt
    FROM od
    ORDER BY amt DESC
    LIMIT 5
)

SELECT o.order_date, c.name, c.amt
FROM od o
 join ctc c
ON o.id = c.id;
  
  
  
  with y as (
  select id, monthname(order_date) as months,sum(amt) as total_revenue from 
  od
  group by id,month(order_date),monthname(order_date)
  order by month(order_date) 
  
  
  )  
  
  select  
  o.product, y.months , y.total_revenue
  from od o
  join y 
  on o.id=y.id
  where  total_revenue>=10000;
  
  
  
  
  select o.name as name  ,o.product as product,o.order_date as orderdate,o.amt as amt,c.city_name as cityname
  from od o
  join city c
  on o.city_id= c.city_id
  order by amt desc limit 5;
  
select o.name as name  ,o.product as product,o.order_date as orderdate,o.amt as amt,c.city_name as cityname
  from od o
   join city c
  on o.city_id= c.city_id
  where o.name like 'A%'
  order by   amt desc;
  
with git as (
select city_id,name ,product, order_date ,amt  from  od
where name like 'A%'
group by city_id ,name, product, order_date, amt 


)
select g.*  ,c.city_name from   git g
 join city c
on g.city_id=c.city_id
order by amt desc ;

with cit as (
select  monthname(order_date) as months ,sum(amt ) as amt from  od
group by   month(order_date),monthname(order_date)
order by month(order_date)

)
select  months,  amt  from    cit;





WITH cit AS (
    SELECT 
        MONTHNAME(order_date) AS months,
        SUM(amt) AS total_amt
    FROM od
    GROUP BY MONTH(order_date), MONTHNAME(order_date)
)

SELECT 
months,
total_amt,
CASE
    WHEN total_amt > 150000 THEN 'High Order'
    WHEN total_amt > 120000 THEN 'Medium Order'
    ELSE 'Low Order'
END AS category
FROM city;


SELECT 
amt, rank() over(order by amt) as rn,
CASE
    WHEN amt > 60000 THEN 'High Order'
    WHEN amt > 50000 THEN 'Medium Order'
    ELSE 'Low Order'
END AS category
FROM od;


select product,amt,dense_rank() over (partition by product  order by amt desc) as rn
from od;

select product,amt,row_number() over (partition by product  order by amt desc) as rn
from od;
select product,amt,rank() over (partition by product  order by amt desc) as rn
from od;

SELECT product, SUM(amt) as total,
dense_rank
() OVER (ORDER BY SUM(amt) DESC) as rnk
FROM od
GROUP BY product;



SELECT 
    DAYNAME(order_date) AS days, SUM(amt) AS amount
FROM
    od
GROUP BY DAYNAME(order_date);
  
  
  
  SELECT 
    monthNAME(order_date) AS days, SUM(amt) AS amount
FROM
    od
GROUP BY monthNAME(order_date);



 
select product,sum(amt )as amt from 
od
group by product 
order by  amt desc;

select name,sum(amt )as amt from 
od
group by name order by  amt desc;

select name,  months,  amt from (

select  name, month(order_date) as months  ,max(amt) as  amt 
from od
group by name,month(order_date) 

)t
order by  amt desc;



SELECT 
    order_date,product,
    LAG(order_date) OVER (ORDER BY order_date) AS prev_date,
    DATEDIFF(order_date, LAG(order_date) OVER (ORDER BY order_date)) AS gap_days
FROM od;

ride_bookingsemployee

