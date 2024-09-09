# Task-1
SELECT  distinct(market) FROM gdb023.dim_customer
where region="APAC" and customer= "Atliq Exclusive";

# Task-2
SELECT X.A AS unique_product_2020, Y.B AS unique_products_2021, ROUND((B-A)*100/A, 2) AS percentage_chg
FROM
     (
      (SELECT COUNT(DISTINCT(product_code)) AS A FROM fact_sales_monthly
      WHERE fiscal_year = 2020) X,
      (SELECT COUNT(DISTINCT(product_code)) AS B FROM fact_sales_monthly
      WHERE fiscal_year = 2021) Y 
	 );

# Task-3
select segment, 
count(distinct(product_code)) as product_count
from dim_product
group by segment
order by product_count desc;

# Task-4
WITH CTE1 AS 
	(SELECT P.segment AS A , COUNT(DISTINCT(FS.product_code)) AS B 
    FROM dim_product P, fact_sales_monthly FS
    WHERE P.product_code = FS.product_code
    GROUP BY FS.fiscal_year, P.segment
    HAVING FS.fiscal_year = "2020"),
CTE2 AS
    (
	SELECT P.segment AS C , COUNT(DISTINCT(FS.product_code)) AS D 
    FROM dim_product P, fact_sales_monthly FS
    WHERE P.product_code = FS.product_code
    GROUP BY FS.fiscal_year, P.segment
    HAVING FS.fiscal_year = "2021"
    )     
    
SELECT CTE1.A AS segment, CTE1.B AS product_count_2020, CTE2.D AS product_count_2021, (CTE2.D-CTE1.B) AS difference  
FROM CTE1, CTE2
WHERE CTE1.A = CTE2.C ;

# Task-5
select p.product_code, p.product, m.manufacturing_cost
from dim_product p
join fact_manufacturing_cost m using (product_code)
where manufacturing_cost in ((select max(manufacturing_cost) from fact_manufacturing_cost), (select min(manufacturing_cost) from fact_manufacturing_cost))
order by manufacturing_cost desc;

# Task-6 

with x as ( select customer_code as A, round(avg(pre_invoice_discount_pct),3)*100 as avg_discount_pct
from fact_pre_invoice_deductions d
where fiscal_year=2021
group by customer_code),
y as ( select customer_code as B, customer 
from dim_customer 
where market = "India")

select x.A, y.customer, avg_discount_pct
from x join y on x.A = y.B
order by avg_discount_pct desc 
limit 5;

# Task-7
SELECT CONCAT(MONTHNAME(FS.date), ' (', YEAR(FS.date), ')') AS 'Month', FS.fiscal_year,
       ROUND(SUM(G.gross_price*FS.sold_quantity), 2) AS Gross_sales_Amount
FROM fact_sales_monthly FS
JOIN dim_customer C ON FS.customer_code = C.customer_code
JOIN fact_gross_price G ON FS.product_code = G.product_code
WHERE C.customer = 'Atliq Exclusive'
GROUP BY  Month, FS.fiscal_year 
ORDER BY FS.fiscal_year;

# Task-8
select 
case
    when date between '2019-09-01' and '2019-11-01' then "Q"  
    when date between '2019-12-01' and '2020-02-01' then "Q2"
    when date between'2020-03-01' and '2020-05-01' then "Q3"
    when date between '2020-06-01' and '2020-08-01' then "Q4"
    end as Quarters,
    SUM(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year = 2020
group by Quarters
order by total_sold_quantity desc;

# Task-9
with x as
(
select C.channel,
       ROUND(SUM(G.gross_price*S.sold_quantity/1000000), 2) as Gross_sales_mln
from fact_sales_monthly S join dim_customer C on S.customer_code = C.customer_code
						   join fact_gross_price G on S.product_code = G.product_code
where S.fiscal_year = 2021
group by channel
)
select channel,  Gross_sales_mln , ROUND(Gross_sales_mln*100/total , 2) as percentage
from
(
(select SUM(Gross_sales_mln) as total from x) A,
(select * from x) B
)
order by percentage desc;

# Task-10
with x as  
(
SELECT P.division, FS.product_code, P.product, SUM(FS.sold_quantity) AS Total_sold_quantity
FROM dim_product P JOIN fact_sales_monthly FS
ON P.product_code = FS.product_code
WHERE FS.fiscal_year = 2021 
GROUP BY  FS.product_code, division, P.product
),
y as 
(
SELECT division, product_code, product, Total_sold_quantity,
        RANK() OVER(PARTITION BY division ORDER BY Total_sold_quantity DESC) AS 'Rank_Order' 
FROM x
)
 SELECT x.division, x.product_code, x.product, y.Total_sold_quantity, y.Rank_Order
 FROM x JOIN y
 ON x.product_code = y.product_code
WHERE y.Rank_Order IN (1,2,3)
