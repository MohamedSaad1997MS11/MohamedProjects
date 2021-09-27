-- Showing our first table (Mohamed Saad Pj)
Select * From PortfolioProject.dbo.covid_19_indiaDeath 

-- Showing second table
Select * From PortfolioProject.dbo.covid_vaccine

-- Select Data that Show how cases evolved by time
Select  date, Cured ,Deaths, Confirmed
From PortfolioProject..covid_19_indiaDeath
Where State is not null 
order by 1,2

--Indian National vs Total cases in india
Select  Date , State , (ConfirmedIndianNational/Confirmed)*100 AS Indian_Nationality_Percentage
From PortfolioProject.dbo.covid_19_indiaDeath
Where Confirmed > 0 and ConfirmedIndianNational is not null
Order by Date , State

--Foreign National vs Total cases in india
Select  Date , State , (ConfirmedForeignNational/Confirmed)*100 AS Foregin_Nationality_Percentage
From PortfolioProject.dbo.covid_19_indiaDeath
Where Confirmed > 0 and ConfirmedForeignNational is not null
Order by Date , State

--Indian National Cases vs Foreign National Cases
Select State, SUM(ConfirmedIndianNational) AS India_National_Cases , SUM(ConfirmedForeignNational) AS foreign_National_Cases
From PortfolioProject.dbo.covid_19_indiaDeath
Group By State

--Cured People vs Total Cases
Select   State , (Sum(Cured)/(SUM(Confirmed)))*100 AS Cured_Percentage
From PortfolioProject.dbo.covid_19_indiaDeath
Where (Confirmed) > 0
Group by  State

-- Deaths vs Total Cases
Select   State , (SUM(Deaths)/(Sum(Confirmed)))*100 AS Death_Percentage
From PortfolioProject.dbo.covid_19_indiaDeath
Where (Confirmed) > 0
Group by State

-- States with Highest Infection Rate compared to Population

Select State ,Max(Confirmed) AS Highest_Cases
From PortfolioProject.dbo.covid_19_indiaDeath
Group By State
Order by Highest_Cases DESC

--First Dose Numbers vs Second Dose Numbers
Select State , SUM([Total Doses Administered]) AS DOSES_TOTAL ,  SUM([First Dose Administered]) AS Dose_1 ,  SUM([Second Dose Administered]) AS Dose_2 
From PortfolioProject.dbo.covid_vaccine
Where ([Total Doses Administered]) IS NOT NULL
Group By State , [Total Doses Administered]

--First Dose Percentage in India
Select State , SUM([Total Doses Administered]) AS DOSES_TOTAL , SUM([First Dose Administered]) AS Dose_1 , SUM(([First Dose Administered]/[Total Doses Administered]))*100 AS First_Dose_Percentage
From PortfolioProject.dbo.covid_vaccine
Where ([Total Doses Administered]) IS NOT NULL
Group By State , [Total Doses Administered]


--Second Dose Percentage in India
Select State , SUM([Total Doses Administered]) AS DOSES_TOTAL , SUM([Second Dose Administered]) AS Dose_2 , SUM(([Second Dose Administered]/[Total Doses Administered]))*100 AS Second_Dose_Percentage
From PortfolioProject.dbo.covid_vaccine
Where ([Total Doses Administered]) IS NOT NULL
Group By State , [Total Doses Administered]

--Calculate Male Doses Percentage
Select State , [Total Doses Administered] ,([Male (Doses Administered)]/[Total Doses Administered])*100 AS  Male_Dose_Percentage
From PortfolioProject.dbo.covid_vaccine
Where [Total Doses Administered] IS NOT NULL
Order By Male_Dose_Percentage DESC

--Calculate Female Doses Percentage
Select State , [Total Doses Administered] ,([Female (Doses Administered)]/[Total Doses Administered])*100 AS Female_Dose_Percentage
From PortfolioProject.dbo.covid_vaccine
Where [Total Doses Administered] IS NOT NULL
Order By Female_Dose_Percentage DESC



--Showing 18-44 years Individuals Vaccinated
Select State , [Total Individuals Vaccinated] ,([18-44 Years(Individuals Vaccinated)] / [Total Individuals Vaccinated])*100 AS Age_18_44_Vaccinated
From PortfolioProject.dbo.covid_vaccine
Where [Total Individuals Vaccinated] IS NOT NULL 
And [18-44 Years(Individuals Vaccinated)] IS NOT NULL
Order By Age_18_44_Vaccinated DESC

--Showing 45-60 years Individuals Vaccinated
Select State , [Total Individuals Vaccinated] ,([45-60 Years(Individuals Vaccinated)]/ [Total Individuals Vaccinated])*100 AS Age_45_60_Vaccinated
From PortfolioProject.dbo.covid_vaccine
Where [Total Individuals Vaccinated] IS NOT NULL 
And [45-60 Years(Individuals Vaccinated)]IS NOT NULL
Order By Age_45_60_Vaccinated DESC

--Showing 60+ years Individuals Vaccinated
Select DISTINCT State ,[Total Individuals Vaccinated] ,([60+ Years(Individuals Vaccinated)]/ [Total Individuals Vaccinated])*100 AS Age_60_Plus_Vaccinated
From PortfolioProject.dbo.covid_vaccine
Where [Total Individuals Vaccinated] IS NOT NULL 
And [60+ Years(Individuals Vaccinated)]IS NOT NULL
Order By Age_60_Plus_Vaccinated DESC

--Total Vaccinated People in india

Select SUM([Total Individuals Vaccinated]) AS Total_Vaccinated_People
From PortfolioProject.dbo.covid_vaccine 

--Total Cases in india

Select SUM(Confirmed) AS Total_Cases
From PortfolioProject.dbo.covid_19_indiaDeath


-- Join Tables to See Total Cases vs Total Vaccinate
Select PortfolioProject.dbo.covid_19_indiaDeath.State , PortfolioProject.dbo.covid_19_indiaDeath.Date ,  SUM(Confirmed) As Total_Confirmed , ([Total Individuals Vaccinated] / (SUM( [Total Individuals Vaccinated] )))*100 AS Percentage_of_Vaccinated_People
From PortfolioProject.dbo.covid_19_indiaDeath 
Join
PortfolioProject.dbo.covid_vaccine
  On PortfolioProject.dbo.covid_19_indiaDeath.State = PortfolioProject.dbo.covid_vaccine.State
  Where PortfolioProject.dbo.covid_19_indiaDeath.Confirmed > 0
  Group by PortfolioProject.dbo.covid_19_indiaDeath.State , PortfolioProject.dbo.covid_vaccine.[Total Individuals Vaccinated] , PortfolioProject.dbo.covid_19_indiaDeath.Date
Order by PortfolioProject.dbo.covid_19_indiaDeath.Date

