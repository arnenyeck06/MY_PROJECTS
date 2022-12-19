use COVIDDATA;
select * from Coviddeaths order by 3, 4;
select * from covidvaccinations order by 3, 4;
-- select usable data. 
select distinct location from CovidDeaths;
select location, date, new_cases, total_deaths, population_density from Coviddeaths order by 1,2;

-- total cases vs total deaths. % people infected
select location, date, total_deaths, total_cases, round((total_deaths/total_cases)* 100, 2) as percentage 
from Coviddeaths where location like '%France%' 
order by 1,2;

-- total cases vs population.Percentage of pop that got covid.
select location, date, total_cases, population_density, round((total_cases/population_density)* 100, 2) as percentage 
from Coviddeaths where location like '%France%' 
order by 1,2;

-- Countries with highest infection rate
select location, population_density,  MAX(total_cases), round(Max(total_cases/ population_density), 3) as infectedPop
from coviddeaths
group by location, population_density
order by infectedPop DESC;
