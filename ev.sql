                -- RegionalAnalysis:
                
-- Which region has the highest adoption rate of  ev cars?
SELECT REGION, 
max(value) AS adoption_count
FROM EV.electric_cars
WHERE mode = 'Ev'
GROUP BY REGION
ORDER BY adoption_count DESC
LIMIT 1;


-- What are the top-selling ev car models in each region?
select
region,
mode,
sum(value) as top_selling
from ev.electric_cars
where mode = 'ev'
group by region , mode ;

-- How do regional preferences vary in terms of power train type ?
SELECT 
    REGION, 
    POWER_TRAIN, 
    COUNT(*) AS COUNT,
    AVG(VALUE) AS AVERAGE_VALUE
FROM 
    EV.electric_cars
GROUP BY 
    REGION, 
    POWER_TRAIN
ORDER BY 
    REGION, 
    COUNT DESC;


                   -- Category Insights:
                   
-- What is the market share of each category  in the ev car market?

SELECT 
    CATEGOERY,
    SUM(value) AS total_value ,  
   (SUM(value) / (SELECT SUM(value) FROM ev.electric_cars)) * 100 AS market_share
    FROM  ev.electric_cars
GROUP BY 
    CATEGOERY
ORDER BY 
    market_share DESC;


-- Which categories are growing the fastest in terms of value?
SELECT 
    CATEGOERY,
    SUM(CASE WHEN year = YEAR(CURDATE()) THEN value ELSE 0 END) AS current_year_sales,
    SUM(CASE WHEN year = YEAR(CURDATE()) - 1 THEN value ELSE 0 END) AS previous_year_sales,
    (SUM(CASE WHEN year = YEAR(CURDATE()) THEN value ELSE 0 END) - 
     SUM(CASE WHEN year = YEAR(CURDATE()) - 1 THEN value ELSE 0 END)) AS growth,
    ((SUM(CASE WHEN year = YEAR(CURDATE()) THEN value ELSE 0 END) - 
      SUM(CASE WHEN year = YEAR(CURDATE()) - 1 THEN value ELSE 0 END)) / 
      NULLIF(SUM(CASE WHEN year = YEAR(CURDATE()) - 1 THEN value ELSE 0 END), 0)) * 100 AS growth_percentage
FROM 
    ev.electric_cars
GROUP BY 
    CATEGOERY
having
 growth > 0
ORDER BY 
    growth_percentage DESC;


-- How do category preferences vary by region?
SELECT 
    region,
    CATEGOERY,
    SUM(value) AS total_value,
    (SUM(value) / (SELECT SUM(value) FROM ev.electric_cars WHERE region = ec.region)) * 100 AS market_share_percentage
FROM 
    ev.electric_cars 
GROUP BY 
    region, categoery
ORDER BY 
    region, total_sales DESC;



    -- Parameter Analysis:

-- What are the most important parameters  influencing ev cars purchases?
SELECT 
    parameter, 
    COUNT(*) AS purchase_count
FROM 
    ev.electric_cars
GROUP BY 
    parameter
ORDER BY 
    purchase_count DESC
LIMIT 10;


-- How do parameter preferences vary by region and category?

SELECT 
    region,
    categoery,
    parameter,
    COUNT(*) AS preference_count
FROM 
    ev.electric_cars
GROUP BY 
    region, CATEGOERY, parameter
ORDER BY 
    region, CATEGOERY, preference_count DESC;


                   -- Mode and Power Train Analysis:
                    
-- What is the market share of different modes in the ev car market?

SELECT 
    mode, 
    SUM(value) AS total_value,
    (SUM(value) / (SELECT SUM(value) FROM ev.electric_cars) * 100) AS market_share_percentage
FROM 
   ev.electric_cars
GROUP BY 
    mode
ORDER BY 
    market_share_percentage DESC;

-- How do power train types vary by region and category?
SELECT 
    region,
    CATEGOERY
    power_train,
    COUNT(*) AS count
FROM 
    ev.electric_cars

GROUP BY 
    region,CATEGOERY,power_train
ORDER BY 
    region, count DESC;


		
              