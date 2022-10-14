-- 1. How many actors are there with the last name ‘Wahlberg’?
select count(last_name) from actor where last_name = 'Wahlberg'

-- 2. How many payments were made between $3.99 and $5.99?
select count(amount) from payment where amount > 3.99 and amount < 5.99

-- 3. What film does the store have the most of? (search in inventory)
select film_id, count(film_id) as count_id
from inventory
group by film_id
order by count_id desc

   --used this function to provide name of movie It's Curtain Videotape
select title from film
where film_id = 200

   -- this provides the film ID and count in one line 
select film_id, count(film_id) as count_id 
from inventory 
group by film_id 
having count(film_id) = (
	select MAX(count_id) as highest_count
	from (
		select film_id, count(film_id) as count_id
		from inventory
		group by film_id
	) t )

-- 4. How many customers have the last name ‘William’?
select count(last_name) from customer where last_name = 'William'

-- 5. What store employee (get the id) sold the most rentals?
select staff_id
from rental
group by staff_id
having count(rental_id) = ( 
	select MAX(count_rental) as rental_total
	from (select staff_id, count(rental_id) as count_rental 
	from rental 
	group by staff_id) t
)

-- 6. How many different district names are there?
select count(distinct district)
from address

-- 7. What film has the most actors in it? (use film_actor table and get film_id)
select film_id
from film_actor 
group by film_id
having count(actor_id)= (
	select MAX(count_id)
	from (
		select film_id, count(actor_id) as count_id
		from film_actor 
		group by film_id
		order by count_id desc
		) t )

-- 8. From store_id 1, how many customers have a last name ending with ‘es’? 
--(use customer table)

select count(last_name)
from customer
where last_name like '%es' and store_id = 1

-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for 
--customers with ids between 380 and 430? (use group by and having > 250)
select count(distinct amount)
from payment 
where amount in (
	select amount
	from payment
	where customer_id > 380 and customer_id < 430
	group by amount
	having count(amount) > 250
	)

-- 10. Within the film table, how many rating categories are there? And what rating has the 
-- most movies total?

	-- this has to appear in two queries 

select count(distinct rating)
from film

select rating 
from film 
group by rating
having count(film_id)= (
	select MAX(count_id)
	from (
		select rating, count(film_id) as count_id
		from film 
		group by rating
		order by count_id desc
		) t )