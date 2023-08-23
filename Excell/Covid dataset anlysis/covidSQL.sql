/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/


/* testing data is inputed*/
Select *
From test.CovidDeaths
order by 3,4;

Select *
From test.covidvaccinations
order by 3,4;

-- selecting relevent data to start
Select Location, date, total_cases, new_cases, total_deaths, population
From test.CovidDeaths
Where continent is not null 
order by 1,2;


-- showing the chance of death in the UK

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From test.CovidDeaths
Where location like '%Kingdom%'
and continent is not null 
order by 1,5;

-- showing the % of population infected

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From test.CovidDeaths
Where location like '%Kingdom%'
order by 1,2;

-- countried with the highest infection rate based on population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From test.CovidDeaths
-- Where continent like '%Europe%'
Group by Location, Population
order by PercentPopulationInfected desc;

-- countried with the highest death count based on population

Select Location, MAX(cast(Total_deaths AS SIGNED)) as TotalDeathCount
From test.CovidDeaths
-- Where continent like '%Europe%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc;

-- BREAKING THINGS DOWN BY CONTINENT

-- Sorting by highest deathcount per population

Select continent, MAX(cast(Total_deaths AS SIGNED)) as TotalDeathCount
From test.CovidDeaths
-- Where continent like '%Europe%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc;


-- Global sum

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths AS SIGNED)) as total_deaths, SUM(cast(new_deaths AS SIGNED))/SUM(New_Cases)*100 as DeathPercentage
From test.CovidDeaths
where continent is not null 
Group By date
order by 1,2;


-- % of population with at least 1 vaccine

SELECT
    dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS signed)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
	-- , (RollingPeopleVaccinated/population)*100
FROM test.CovidDeaths dea
JOIN test.CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

-- using last query to do caculations on partitions

WITH PopvsVac AS (
    SELECT
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
    FROM
        test.CovidDeaths dea
    JOIN
        test.CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
    WHERE
        dea.continent IS NOT NULL
        -- AND dea.continent = '%Europe%'
)
SELECT
    *,
    (RollingPeopleVaccinated / Population) * 100
FROM
    PopvsVac;


-- Using Temp Table to perform Calculation on Partition By in previous query


DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated (
  Continent VARCHAR(255),
  Location VARCHAR(255),
  Date DATETIME,
  Population DECIMAL,
  New_vaccinations DECIMAL,
  RollingPeopleVaccinated DECIMAL
);

INSERT INTO PercentPopulationVaccinated
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(CONVERT(vac.new_vaccinations, SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM test.CovidDeaths dea
JOIN test.CovidVaccinations vac
  ON dea.location = vac.location
  AND dea.date = vac.date;

SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM PercentPopulationVaccinated;


DROP TABLE IF EXISTS tmp_PercentPopulationVaccinated;
CREATE TEMPORARY TABLE tmp_PercentPopulationVaccinated (
  Continent VARCHAR(255),
  Location VARCHAR(255),
  Date DATETIME,
  Population DECIMAL,
  New_vaccinations DECIMAL,
  RollingPeopleVaccinated DECIMAL
);

INSERT INTO tmp_PercentPopulationVaccinated
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(CONVERT(vac.new_vaccinations, SIGNED)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM test.CovidDeaths dea
JOIN test.CovidVaccinations vac
  ON dea.location = vac.location
  AND dea.date = vac.date;

SELECT *, (RollingPeopleVaccinated / Population) * 100
FROM tmp_PercentPopulationVaccinated;

