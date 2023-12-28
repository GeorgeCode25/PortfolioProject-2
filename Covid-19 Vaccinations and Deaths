--Data we are going to be using
-Select location, date, total_cases, new_cases, total_deaths, population 
From CovidDeaths order by 1,2


--Looking at Total Cases vs Total Deaths
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc



--Showing Countries with Highest Death Count per population
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount    
From CovidDeaths
--WHERE location like '%states%' 
Where continent is not null
Group By location, population 
Order By TotalDeathCount desc

--Looking at Total Vaccincations Vs Populations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by Dea.location ORDER BY dea.location, dea.date) 
as RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2, 3

--Break the data into continents
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount    
From CovidDeaths
--WHERE location like '%states%' 
Where continent is not null

--Showing continents with the highest death count per population
Select continent, MAX(cast (Total_deaths as int)) as TotalDeathCount 
From CovidDeaths
--Where location like '%states%* 
Where continent is not null 
Group By continent 
Order By TotalDeathCount desc


--Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast (new_deaths as int))/SUM(new_Cases) *100 as DeathPercentage 
From CovidDeaths
--Where location like '%states%' 
WHERE continent is not null 
--Group By date
ORDER BY 1,2

--Create View for Later Visualizations
CREATE VIEW TotalDeathCount as
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount    
From CovidDeaths
--WHERE location like '%states%' 
Where continent is not null
Group By location, population 
