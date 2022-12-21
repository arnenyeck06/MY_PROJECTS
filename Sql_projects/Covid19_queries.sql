use COVIDDATA;
select * from Coviddeaths order by 3, 4;

-- select usable data. 
select distinct continent 
from CovidDeaths;
select continent, date, new_cases, total_deaths, population_density from Coviddeaths order by 1,2;

-- total cases vs total deaths. % people infected
select continent, date, total_deaths, total_cases, round((total_deaths/total_cases)* 100, 2) as percentage 
from Coviddeaths where location like '%France%' 
order by 1,2;

-- total cases vs population.Percentage of pop that got covid.
select continent, date, total_cases, population_density, round((total_cases/population_density)* 100, 2) as percentage 
from Coviddeaths where location like '%France%' 
order by 1,2;

-- Countries with highest infection rate
select continent, population_density,  MAX(total_cases), round(Max(total_cases/ population_density), 3) as infectedPop
from coviddeaths
group by continent, population_density
order by infectedPop DESC;

-- Countries with highest death count per population .. *** CAST as int
select continent,  MAX(total_deaths) as totalDeathCount
from coviddeaths
group by continent;


-- Countries with highest death count per population  by continent.. *** CAST as int
select  location, SUM(total_deaths)
from coviddeaths
where continent is not null
group by location
order by totalDeathCount DESC;

-- GLOBAL NUMBERS
select continent, SUM(new_cases), SUM(new_deaths)
from coviddeaths
where continent is not null
group by continent;

select date, SUM(new_cases), SUM(new_deaths)/SUM(New_cases)*100 as death_percentage
from coviddeaths
where continent is not null
group by date
order by 1;

select *
from covidvaccinations;

-- populationb vs vaccinations.
select coviddeaths.continent, coviddeaths. location, coviddeaths.population_density, covidvaccinations.new_vaccinations
from coviddeaths
join covidvaccinations on coviddeaths.location = covidvaccinations.location
and coviddeaths.date = covidvaccinations.date
where coviddeaths.continent is not null
order by 2,3;

select coviddeaths.date, coviddeaths.location, coviddeaths.population_density, covidvaccinations.new_vaccinations_smoothed,
SUM(covidvaccinations.new_vaccinations_smoothed) OVER (Partition by coviddeaths.location order by coviddeaths.location) as Rolling_poepVac
from coviddeaths
join covidvaccinations on coviddeaths.location = covidvaccinations.location
and coviddeaths.date = covidvaccinations.date
where coviddeaths.continent is not null
order by 2,3;

-- CTE to use Rolling_poepVac
with PopvsVac(continent, location, date, population, new_vaccinations_smoothed, Rolling_peopVac)
as
(select coviddeaths.continent, coviddeaths.location, coviddeaths.population_density, covidvaccinations.new_vaccinations_smoothed,
SUM(covidvaccinations.new_vaccinations) OVER (Partition by coviddeaths.location order by coviddeaths.location) as Rolling_poepVac
from coviddeaths
join covidvaccinations on coviddeaths.location = covidvaccinations.location
and coviddeaths.date = covidvaccinations.date
where coviddeaths.continent is not null
-- order by 2,3
)
select * from PopvsVac

-- TEMP TABLE
Drop table if exists #PercentPopVac
create table #PercentPopVac
(
continentnvarcahr(200),
location nvarchar(200),
date datetime,
Populatuion numeric,
new_vaccinations_smoothed numeric,
Rolling_poepVac numeric
)
insert into #PercentPopVac
select coviddeaths.continent, coviddeaths.location, coviddeaths.population_density, covidvaccinations.new_vaccinations_smoothed,
SUM(covidvaccinations.new_vaccinations) OVER (Partition by coviddeaths.location order by coviddeaths.location) as Rolling_poepVac
from coviddeaths
join covidvaccinations on coviddeaths.location = covidvaccinations.location
and coviddeaths.date = covidvaccinations.date
where coviddeaths.continent is not null
-- order by 2,3
select *, (Rolling_poepVac/Population_density)*100
from #PercentPopVac








