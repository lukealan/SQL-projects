SELECT * FROM walmart_project.`walmartsalesdata`;

#---- adding time_of_day column -----

ALTER Table	walmart_project.`walmartsalesdata`
 add column time_of_day varchar(20);
update walmart_project.`walmartsalesdata`
set time_of_day = (
case
when time between "00:00:00" and "12:00:00" then "Morning"
when time between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening"
end
);

#------- adding day_name column ------

select date, dayname(date) from walmartsalesdata;
alter Table walmartsalesdata add column day_name varchar(20);
update walmartsalesdata
set day_name = dayname(date);

#------- adding month_name column ------

select date, monthname(date) from walmartsalesdata;
alter Table walmartsalesdata add column month_name varchar(20);
update walmartsalesdata
set month_name = monthname(date);

#--------------------------Questions-------------------------------------
# How many unique cities does the data have?
select distinct city 
from walmartsalesdata;

# In which city is each branch?
select distinct city, branch
from walmartsalesdata;

# How many unique product lines does the data have?
select count(distinct Product_line)
from walmartsalesdata;

# What is the most common payment method?
select payment, count(Payment) as counted
 from walmartsalesdata
 group by Payment;
 
 # What is the most selling product line?
select Product_line, count(Product_line) as counted
 from walmartsalesdata
 group by Product_line
 order by counted desc;
 
 # What is the total revenue by month?
 select month_name, round(sum(Total)) as total_revenue
 from walmartsalesdata
 group by month_name
 order by sum(Total) desc;
 
 # What month had the largest COGS?
 select month_name, sum(cogs) as total_cogs
 from walmartsalesdata
 group by month_name
 order by total_cogs desc;
 
 # What product line had the largest revenue?------
 select Product_line, sum(total) as total_revenue
 from walmartsalesdata
 group by Product_line
 Order by total_revenue desc;
 
 # What is the city with the largest revenue?
 select City, round(sum(Total)) as tot_rev
 from walmartsalesdata	
 group by City
 order by tot_rev;

# What product line had the largest VAT?
select Product_line, avg(Vat) AS avg_vat
from walmartsalesdata
group by Product_line
order by avg_vat desc;

# Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select product_line,(
	case
		when quantity > (select avg(quantity) from walmartsalesdata) then "Good"
		Else "Bad"
	end
) as remark
from walmartsalesdata;

# Which branch sold more products than average product sold?
select branch, sum(quantity) as qty
from walmartsalesdata
group by Branch
having qty > (select avg(quantity) from walmartsalesdata);

# What is the most common product line by gender?
select gender, product_line, count(gender) as total_gender
from walmartsalesdata
group by gender, Product_line
order by count(gender);

# What is the average rating of each product line?
select Product_line, round(avg(rating),2) as avg_rating
from walmartsalesdata
group by Product_line ;

# Number of sales made in each time of the day per weekday
select time_of_day, 
count(total) as sales
from walmartsalesdata
where day_name = "Monday"  # change the da_name between Monday to Friday.
group by time_of_day
order by sales desc;

# Which of the customer types brings the most revenue?
select customer_type, round(sum(total),2) as revenue 
from walmartsalesdata
group by customer_type
order by revenue desc;

# Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, avg(Vat) as max_vat
from walmartsalesdata
group by city
order by max_vat desc;

# Which customer type pays the most in VAT?
select customer_type, avg(Vat) as max_vat
from walmartsalesdata
group by customer_type
order by max_vat desc;

# How many unique customer types does the data have?
select distinct customer_type 
from walmartsalesdata;

# How many unique payment methods does the data have?
select distinct payment 
from walmartsalesdata;

# What is the most common customer type?
select customer_type, count(customer_type) as num
from walmartsalesdata
group by customer_type
order by num desc;

# Which customer type buys the most?
select customer_type, count(*) as customer_count
from walmartsalesdata
group by customer_type;

# What is the gender of most of the customers?
select gender, count(*) as numb
from	walmartsalesdata
group by gender;

# What is the gender distribution per branch?
select gender, count(*) as numb
from	walmartsalesdata
where branch = 'B'  # change the branch between A,B,C.
group by gender;

# Which time of the day do customers give most ratings?
select time_of_day, avg(rating) as avg_rating
from walmartsalesdata
group by time_of_day;

# Which time of the day do customers give most ratings per branch?
select time_of_day, avg(rating) as avg_rating
from walmartsalesdata
where branch = "A"  # change the bracnh between A,B,C to get details for the specific branch.
group by time_of_day;

# Which day fo the week has the best avg ratings?
select day_name, avg(rating) as avg_rating
from walmartsalesdata
group by day_name
order by avg_rating desc;

# Which day of the week has the best average ratings per branch?
select day_name, avg(rating) as avg_rating
from walmartsalesdata
where branch = "C"  # change the bracnh between A,B,C to get details for the specific branch.
group by day_name
order by avg_rating desc;
