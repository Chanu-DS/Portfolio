select continent,location,date,total_cases,new_cases,total_deaths,population from CovidDeaths where continent is not null order by 1,2 ;

-- 1)Looking at Total cases vs Todal deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage from CovidDeaths where continent is not null order by 1,2;             ;

-- 2)In India
select location,date,total_cases
      ,total_deaths,(total_deaths/total_cases)*100 
	  as DeathPercentage from CovidDeaths 
	  where location like 'India' 
	  and
	  continent is not null 
	  order by 1,2;

select location,date,total_cases
      ,total_deaths,population,(total_deaths/population)*100 
	  as DeathPercent_population 
	  ,(total_deaths/total_cases)*100 
	  as DeathPercentage_cases from CovidDeaths 
	  where location like 'India' order by total_deaths DESC;
	-- Max Cases count in each location and it's percentage over population
select location ,population
       ,MAX(total_cases) as Max_Infection_location
	   ,MAX((total_cases/population)*100) as Max_Infection_Population_Percentage 
	   from CovidDeaths
	   where continent is not null
	   GROUP BY location,population
	   order by 4 desc;

	   -- Max Death Count in each country
select continent,location ,population
       ,MAX(cast(total_deaths as int)) as Max_DeathsIN_location
	   ,MAX((total_deaths/population)*100) as Max_Deaths_Population_Percentage 
	   from CovidDeaths
	   --where continent is not null
	   GROUP BY continent,location,population	   
	   order by continent asc;

-- 3)Exploring Continents and Locations
select continent,count(continent) 
from CovidDeaths group by continent 
order by continent;

--there are NULL in continent

select location,continent from CovidDeaths where location='Asia';
select location,continent from CovidDeaths where location='Africa';
select location,continent from CovidDeaths where location='Ocenia';
select location,continent from CovidDeaths where location='North America';
select location,continent from CovidDeaths where location='South America';
select location,continent from CovidDeaths where location='Europe';

--How many nulls exist in Continent
select location,continent,count(location) 
from CovidDeaths where location='Asia' 
or location='Africa' 
or  location='Ocenia' 
or location='North America'
or location='South America'
or location='Europe'
group by location,continent 
;

/*In location column we have Continent names instead of country names for some part of the total rows 
and corresponding continent values are null
So, we need to keep in mind that we may have to avoid those rows for some queries*/


select continent,count(continent) from CovidDeaths where location like 'Africa' or location like 'Asia' or location like 'Europe'
or location like 'Asia' or location like 'Oceania' or location like 'South America'
group by continent;
--
select top 1 * from CovidDeaths where location like 'asia'; 

select continent,count(location),location from CovidDeaths 

where location like 'Africa' or location like 'Asia' or location like 'Europe'
or location like 'Asia' or location like 'Oceania' or location like 'South America'
group by continent,location;

-----------------UPDATING CONTINENT AND LOCATION COLUMNS------------------------------------------

--replacing null values in continent 
update CovidDeaths set continent=location where continent is null;
--verify the change
select continent,location,count(continent) from CovidDeaths where continent=location group by continent,location ;
---VERIFIED
--no null in continent


--SET LOCATION TO NULL WHERE LOCATION FIELDS CONTAINS CONTINENT NAMES
update CovidDeaths set location=NULL where continent =location;

-------------------COONTINENT AND LOCATION ARE UPDATED--------------------------------------------------------

-- 4)total deaths in each continent

select continent,sum(cast(total_deaths as int)) as TotalDeacthCount

from CovidDeaths
group by continent;


-- 5)total deaths in each location

select location,sum(cast(total_deaths as int)) as TotalDeacthCount

from CovidDeaths
group by location;


--5)Showing the continents with highest death percent over population
select continent,(sum(cast(total_deaths as int)/population))*100 as TotalDeacthCount

from CovidDeaths
group by continent;


--6)Showing the COUNTRIES with highest death percent over population
select location,(sum(cast(total_deaths as int)/population))*100 as TotalDeathsCount
from CovidDeaths
group by location;

--7)GLOBAL NUMBERS
select /*date,*/sum(new_cases) as Sum_ofNewCases,sum(cast(new_deaths as int)) as Sum_ofNewDeaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercent_onCases
from CovidDeaths
	  where continent is not null 
	  --group by date
	  order by 1,2;

--------------------------------------------------------------------------------------------------------

--Vaccination Table
select top 100 * from CovidVaccination;

-- JOINING BOTH TABLES
select * from CovidDeaths dea join CovidVaccination  vac
on dea.location=vac.location 
and dea.date=vac.date

-- looking at vaccination per population

select  dea.continent,dea.location,dea.date
,dea.population,vac.new_vaccinations
--,sum(cast(vac.new_vaccinations as int)) over 
--(partition by dea.location order by dea.location,dea.date) as PeopleVaccinated_RollingCOunt
from CovidDeaths dea join CovidVaccination  vac
on dea.location=vac.location 
and dea.date=vac.date
where dea.continent is not null
order by 5;


alter table CovidDeaths alter column  location varchar(100);
--USE CTE
with PopvsVac(continent,location,date,Population,new_vaccinations,PeopleVaccinated_RollingCOunt)
as
(
select  dea.continent,dea.location,dea.date
,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location,dea.date) as PeopleVaccinated_RollingCOunt
from CovidDeaths dea join CovidVaccination  vac
on dea.location=vac.location 
and dea.date=vac.date
where dea.continent is not null
--order by 5
)
select *,(PeopleVaccinated_RollingCOunt/population)*100 from PopvsVac
--------------------------------------------------------------------------------------------------------------

--8)TEMP TABLE

drop table if exists #PercentPopVaccinated
create table #PercentPopVaccinated
(
continent nvarchar(255),
location nvarchar(100),
date datetime,
population numeric,
new_vaccination numeric,
PeopleVaccinated_rollingcount numeric)

insert into #PercentPopVaccinated
select  dea.continent,dea.location,dea.date
,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location,dea.date) as PeopleVaccinated_RollingCOunt
from CovidDeaths dea join CovidVaccination  vac
on dea.location=vac.location 
and dea.date=vac.date
where dea.continent is not null
--order by 5;

select *,(PeopleVaccinated_RollingCOunt/population)*100 
from #PercentPopVaccinated   


--9)CREATING A VIEW TO STORE DATA FOR LATER DATAVIZ.

create view PercentPop_Vaccinated as
select  dea.continent,dea.location,dea.date
,dea.population,vac.new_vaccinations
,sum(cast(vac.new_vaccinations as int)) over 
(partition by dea.location order by dea.location,dea.date) as PeopleVaccinated_RollingCOunt
from CovidDeaths dea join CovidVaccination  vac
on dea.location=vac.location 
and dea.date=vac.date
where dea.continent is not null
--order by 5;

select top 500 * from PercentPop_Vaccinated;
