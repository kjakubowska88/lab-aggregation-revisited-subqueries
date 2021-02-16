/** Write the SQL queries to answer the following questions:**/

/**1. Select the first name, last name, and email address of all the customers who have rented a movie. **/

/** select c.customer_id As ID, c.first_name as F_Name, c.last_name as L_Name, c.email as Email
from customer as c
join rental as r 
on c.customer_id=r.customer_id
where r.rental_date not in (' ','','NULL')
group by c.customer_id
order by c.customer_id ASC; **/

select customer_id as id, first_name as Fname, last_name as Lname, email as E_mail 
from customer
where customer_id IN ( select customer_id from rental);

/**2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).**/

select p.customer_id as ID, CONCAT(c.first_name, ' ' ,c.last_name) as Name, round(AVG(p.amount),2) as Average_pay from payment as p
join customer as c
on c.customer_id = p.customer_id
group by p.customer_id;

/**3. Select the name and email address of all the customers who have rented the "Action" movies.
Write the query using multiple join statements
Write the query using sub queries with multiple WHERE clause and IN condition
Verify if the above two queries produce the same results or not**/

-- 1 --
select CONCAT(c.first_name, ' ' ,c.last_name) as Name, c.email as E_mail from customer as c
join rental as r on c.customer_id = r.customer_id
join inventory as i on r.inventory_id = i.inventory_id
join film_category as fc on i.film_id = fc.film_id
where fc.category_id = '1' 
group by c.customer_id;

-- 2 --
/**
select CONCAT(first_name, ' ' ,last_name) as Name, email as E_mail from customer 
where customer_id in (select customer_id from rental where inventory_id in (select inventory_id from inventory where inventory_id in (select film_id from film_category where category_id = '1')));
**/

select concat(first_name,' ',last_name) as CustomerName, email from customer
where customer_id in(
select customer_id from rental
where inventory_id in (
select inventory_id from inventory
where film_id in (
select film_id from film_category
where category_id in (
select category_id from category
where name = "Action"))));

/**4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.**/

select *,
case
    when amount < 2 then "low"
    when 2 < amount < 4 then "medium"
    else "high"
end as transaction_value
from payment;


