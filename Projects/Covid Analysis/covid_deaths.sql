/**************                          Covid Analysis                     *****************/
SELECT * FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2

SELECT 
 location,
 date,
 total_cases,
 new_cases,
 total_deaths,
 population
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths -- 
-- Shows odds of death contracting covid in the US
SELECT 
 location,
 date,
 total_cases,
 total_deaths,
 (total_deaths/total_cases)*100 AS death_percentage
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2



-- Total Cases vs Population --
-- Percentage of population that has gotten Covid --
SELECT 
 location,
 date,
 total_cases,
 population,
 (total_cases/population)*100 AS contraction_rate
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2



-- Contries with Highest Infection Rate compared to Population --
SELECT 
 location,
 population,
 MAX(total_cases) AS highest_infection_count,
 MAX((total_cases/population))*100 AS percent_pop_infected
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_pop_infected DESC



-- Showing Countires with Highest Death Count per Population --
SELECT 
 location,
 MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC

-- By Continent --
SELECT 
 location,
 MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM CovidData..covid_deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC



-- Global Numbers --
SELECT 
 SUM(new_cases) AS global_cases,
 SUM(CAST(new_deaths AS INT)) AS global_deaths,
 SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS global_death_percentage
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
ORDER BY 1,2

SELECT 
 date,
 SUM(new_cases) AS global_cases,
 SUM(CAST(new_deaths AS INT)) AS global_deaths,
 SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS global_death_percentage
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2




-- Total Population vs Vaccinations
WITH popbyvac (continent, location, date, population, new_vaccinations, rolling_people_vac)
AS
(
SELECT 
 d.continent,
 d.location,
 d.date,
 d.population,
 v.new_vaccinations,
 SUM(CAST(v.new_vaccinations AS INT)) OVER(PARTITION BY d.location
	ORDER BY d.location, d.date) AS rolling_people_vac
FROM CovidData..covid_deaths AS d
JOIN CovidData..covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL
)
SELECT *, (rolling_people_vac/population)*100 AS percent_vac FROM popbyvac ORDER BY 2,3


-- We could also do this task with a temp table --


DROP TABLE #percentpeoplevaccinated
CREATE TABLE #percentpeoplevaccinated
(
continent NVARCHAR(255),
location NVARCHAR(255),
date DATETIME,
population NUMERIC,
new_vaccinations NUMERIC,
rolling_people_vac NUMERIC
)

INSERT INTO #percentpeoplevaccinated
SELECT 
 d.continent,
 d.location,
 d.date,
 d.population,
 v.new_vaccinations,
 SUM(CAST(v.new_vaccinations AS INT)) OVER(PARTITION BY d.location
	ORDER BY d.location, d.date) AS rolling_people_vac
FROM CovidData..covid_deaths AS d
JOIN CovidData..covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL

SELECT *, (rolling_people_vac/population)*100 AS percent_vac FROM #percentpeoplevaccinated ORDER BY 2,3

-- Life Expectancy --
SELECT
 location,
 MAX(ROUND(population_density, 0)) AS population_density,
 MAX(ROUND(life_expectancy, 0)) AS life_expectancy,
 MAX(ROUND(male_smokers, 0)) AS male_smokers,
 MAX(ROUND(female_smokers, 0)) AS female_smokers,
 MAX(ROUND(diabetes_prevalence, 2)) AS diabetes_prevalence,
 MAX(ROUND(gdp_per_capita, 2)) AS gdp_per_capita
FROM CovidData..covid_vaccinations
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 3 DESC

-- New Covid Tests --
SELECT
 location,
 date,
 SUM(CAST(new_tests AS INT)) AS new_tests,
 SUM(CAST(total_tests AS INT)) AS total_tests
FROM CovidData..covid_vaccinations
WHERE new_tests IS NOT NULL AND total_tests IS NOT NULL
GROUP BY location, date
ORDER BY 1,2

-- Percent ICU Patients -- 
SELECT
 location,
 date,
 icu_patients,
 hosp_patients,
 CASE	
	WHEN hosp_patients = 0
	THEN NULL
	ELSE CAST(icu_patients AS float) / CAST(hosp_patients AS float) * 100
	END AS percent_icu_patients
FROM CovidData..covid_deaths
WHERE icu_patients IS NOT NULL AND hosp_patients IS NOT NULL




-- VIEWS FOR DATA VISUALISATIONS --

CREATE VIEW PercentPeopleVaccinated AS
SELECT 
 d.continent,
 d.location,
 d.date,
 d.population,
 v.new_vaccinations,
 SUM(CAST(v.new_vaccinations AS INT)) OVER(PARTITION BY d.location
	ORDER BY d.location, d.date) AS rolling_people_vac
FROM CovidData..covid_deaths AS d
JOIN CovidData..covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL


CREATE VIEW TotalCasesVsDeaths AS
SELECT 
 location,
 date,
 total_cases,
 total_deaths,
 (total_deaths/total_cases)*100 AS death_percentage
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL


CREATE VIEW TotalCasesVsPopulation AS
SELECT 
 location,
 date,
 total_cases,
 population,
 (total_cases/population)*100 AS contraction_rate
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL


CREATE VIEW HighestInfected AS
SELECT 
 location,
 population,
 MAX(total_cases) AS highest_infection_count,
 MAX((total_cases/population))*100 AS percent_pop_infected
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population

CREATE VIEW HighestInfectedContinent AS
SELECT 
 location,
 MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM CovidData..covid_deaths
WHERE continent IS NULL
GROUP BY location

CREATE VIEW GlobalCases AS
SELECT 
 SUM(new_cases) AS global_cases,
 SUM(CAST(new_deaths AS INT)) AS global_deaths,
 SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS global_death_percentage
FROM CovidData..covid_deaths
WHERE continent IS NOT NULL


CREATE VIEW NewCovidTests AS
SELECT
 location,
 date,
 SUM(CAST(new_tests AS INT)) AS new_tests,
 SUM(CAST(total_tests AS INT)) AS total_tests
FROM CovidData..covid_vaccinations
WHERE new_tests IS NOT NULL AND total_tests IS NOT NULL
GROUP BY location, date


CREATE VIEW LifeExpectancy AS 
SELECT
 location,
 MAX(ROUND(population_density, 0)) AS population_density,
 MAX(ROUND(life_expectancy, 0)) AS life_expectancy,
 MAX(ROUND(male_smokers, 0)) AS male_smokers,
 MAX(ROUND(female_smokers, 0)) AS female_smokers,
 MAX(ROUND(diabetes_prevalence, 2)) AS diabetes_prevalence,
 MAX(ROUND(gdp_per_capita, 2)) AS gdp_per_capita
FROM CovidData..covid_vaccinations
WHERE continent IS NOT NULL
GROUP BY location

CREATE VIEW PercentICUPatients AS
SELECT
 location,
 date,
 icu_patients,
 hosp_patients, 
 CASE	
	WHEN hosp_patients = 0
	THEN NULL
	ELSE CAST(icu_patients AS float) / CAST(hosp_patients AS float) * 100
	END AS percent_icu_patients
FROM CovidData..covid_deaths
WHERE icu_patients IS NOT NULL AND hosp_patients IS NOT NULL