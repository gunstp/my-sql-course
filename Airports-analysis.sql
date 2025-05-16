/*
Airports Exercise
 
Data source: https://ourairports.com/data/
Data dictionary: https://ourairports.com/help/data-dictionary.html
 
In this exercise we analyse the countries, airports and airports_frequencies table
These have  matching columns:
* airports.ident matches airport_frequencies.airport_ident
* countries.code matches airports.iso_country
*/
 
-- Show 10 sample rows of the airports table
SELECT  TOP 10 * FROM   countries c
where c.continent = 'EU';
 
-- Show 10 sample rows of the airports table
SELECT  TOP 10 * FROM   airports a
where a.elevation_ft > 1000
 
-- Show 10 sample rows of the airports_frequencies table
SELECT  TOP 10 * FROM airport_frequencies af
where af.fequency_mhz between 120 and 130
Order by af.fequency_mhz ASC;
 
-- These are the more interesting columns of the airports table  that we use in this exercise
SELECT TOP 10
    a.ident
    , a.iata_code
    , a.name
    , a.[type]
    , a.latitude_deg
    , a.longitude_deg
    , a.elevation_ft
    , a.iso_country
FROM airports a;
 
-- How many airports are in the airports table?
SELECT COUNT(*) AS [Number of airports]
FROM airports a;
 
-- are there any airports with the same name ?
SELECT a.name, COUNT(*) AS [Number of airports]
FROM airports a
GROUP BY a.name
having COUNT(*) > 1
ORDER BY [Number of airports] DESC;


-- How many frequencies are in the airport_frequencies table?
 
-- How many airports of each type?
SELECT COUNT(*) as [No of Airports],
a.type
from airports a
group by a.TYPE
Order by 1 DESC;

Select
    a.ident
    ,a.iata_code
    ,a.name
    ,a.latitude_deg
    ,a.longitude_deg
    ,a.iso_country
    --,c.continent
FROM
    airports a 
    --left JOIN countries c ON a.iso_country = c.code
WHERE 
a.type = 'large_airport'

and a.iso_country IN (Select code from countries c where c.continent = 'EU')
--and c.continent = 'EU' 
--AND a.iso_country IN ('GB', 'FR')

     

-- Is the airport.ident column unique? i.e. there are no duplicate values
 
/*
Do a data quality check on the airports_frequencies table
Are there any orphan rows (frequencies without a matching airports)?
You can do this is several ways: LEFT JOIN, NOT IN, NOT EXISTS,...
*/
-- left join approach
 
-- NOT EXISTS approach  
 
-- NOT IN approach  
 
/*
1. List airports.  Show the following columns: ident, iata_code, name, latitude_deg, longitude_deg




2. Filter to those airports
  (a) of large_airports type
  (b) in the United Kingdom or France (iso_country  GB, FR)
  [advanced - in Europe i.e., country.continent = 'EU']
  (c) that have a latitude between 49 and 54 degrees
3. Order from the most northern airports to most southern airports
*/
 
 
/*
List the iso_country of the 5 countries with the most airports
List in order of number of airports (highest first)
*/
 
 
/*
How many airports are in those 5 countries (with the most airports)?
Use three different approaches: temp table, CTE, subquery
*/
 
-- Write the temp table approach below here
 
 
-- Write the CTE approach below here
 
-- Write the subquery approach below here
 
/*
List those large airports (if any) without a frequency
*/
 
 
/*
List airports (if any) that have missing (NULL) values for *both* latitude or longitude.
*/
 
/*
List airports (if any) that have missing (NULL) values for *either* latitude or longitude  but not both.
This may indicate some sort of data quality issue.
*/

 