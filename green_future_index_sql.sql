use teamproject;

# Total emission of a country depending on the population rank 

SELECT p.country, g.total_emissions, g.total_energy_transition, g.total_clean_innovation, p.population_rank 
FROM green_totalscores g 
JOIN population_index p 
ON g.country_id = p.country 
WHERE g.total_emissions < 5 
ORDER BY p.population_rank
LIMIT 10 ; 

# Link between the score of green_building and the carbon_emission  
SELECT c.country_id, c.carbon_emissions, gr.green_buildings, gr.forestation_change 
FROM carbon_emissions c 
JOIN green_society gr 
USING (country_id) 
WHERE gr.green_buildings > 5 
ORDER BY c.carbon_emissions;

# Energy_investment of the countries and their carbon_emission 
SELECT c.country_id, c.carbon_emissions, cl.energy_investment 
FROM carbon_emissions c 
JOIN clean_innovation cl 
USING (country_id) 
WHERE cl.energy_investment > 6 
ORDER BY cl.energy_investment DESC 
LIMIT 10; 

# Score of the agriculture strategy of the countries and their score of renewable energy. 
SELECT cli.country_id, cli.agriculture_strategy, e.renewable_energy, e.renewable_contribution 
FROM climate_policy cli 
JOIN energy_transition e 
USING (country_id) 
WHERE e.renewable_energy > 6 
ORDER BY cli.agriculture_strategy DESC 
LIMIT 10; 

# Average of the green index by continent 
SELECT continent, AVG(green_index) AS mean_green_index 
from continent_list 
JOIN carbon_emissions 
USING (country_id) 
JOIN climate_policy 
USING (country_id) 
JOIN green_totalscores 
USING (country_id) 
GROUP BY continent 
ORDER BY mean_green_index DESC; 

# Average carbon emission for europe 
select avg(carbon_emissions), continent 
from carbon_emissions 
join continent_list 
using (country_id) 
where continent regexp "eu"; 

# Average carbon emission for asia 
select avg(carbon_emissions), continent 
from carbon_emissions 
join continent_list 
using (country_id) 
where continent regexp "^.{4}$"; 

# Average carbon emission for south america 
select avg(carbon_emissions), continent 
from carbon_emissions 
join continent_list 
using (country_id) 
where continent regexp "^sout"; 

