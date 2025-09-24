-- Data Cleaning

use layoffs
select * from layoffs;

--1 Remove Duplicates
--2 Standarized Data
--3 Remove Null Values & Blank Values
--4 Remove Any Unnecessary Column

Select * into layoffs_staging
from layoffs;

select *,
ROW_NUMBER() over(
partition by company, industry, total_laid_off, [date] order by company
) as row_num
from layoffs_staging;

--1 Remove Duplicates
-- Use CTE

with duplicate_Layoffs AS (
select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, [date], 
stage, country, funds_raised_millions order by company
) as row_num
from layoffs_staging
)
SELECT *
FROM duplicate_Layoffs
WHERE row_num > 1
order by company;




-- Delete Row Number > 1

with duplicate_Layoffs AS (
select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, [date], 
stage, country, funds_raised_millions order by company
) as row_num
from layoffs_staging
)
Delete 
FROM duplicate_Layoffs
WHERE row_num > 1;


select * From layoffs_staging;


-- row_num is not a part of layoffs_staging so we need make a new table with row_num

CREATE TABLE [dbo].[layoffs_staging2](
	[company] [varchar](50) NULL,
	[location] [varchar](50) NULL,
	[industry] [varchar](50) NULL,
	[total_laid_off] [varchar](50) NULL,
	[percentage_laid_off] [varchar](50) NULL,
	[date] [varchar](50) NULL,
	[stage] [varchar](50) NULL,
	[country] [varchar](50) NULL,
	[funds_raised_millions] [varchar](50) NULL,
	[row_num] [INT] NULL
) ON [PRIMARY]

Select * From layoffs_staging2;

Insert into layoffs_staging2
select *,
ROW_NUMBER() over(
partition by company, location, industry, total_laid_off, [date], 
stage, country, funds_raised_millions order by company
) as row_num
from layoffs_staging;


--2 Standardizing Data

Select company, trim(company) as trim_company
from layoffs_staging2;

-- Updated Trim Column with orignal Company

update layoffs_staging2
set	company = trim(company);

-- Updated Industry column where cyrpto & Crypto currency  with same name crypto

select *
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';


--3 Remove Null Values & Blank Values
--Delete the rows where industry = date  To removing date value null & Blank values also deleted

delete from layoffs_staging2
where ISDATE(industry) = 1;



select distinct country, TRIM(trailing '.' from country)
from layoffs_staging2;

-- update country after timing space & .

update layoffs_staging2
Set country = TRIM(trailing '.' from country)
where country like 'United States%';

--Convert Date Format

SELECT [date]
FROM layoffs_staging2
WHERE TRY_CONVERT(DATE, [date], 101) IS NULL 
  AND [date] IS NOT NULL;

  SELECT [date],
       TRY_CONVERT(DATE, [date], 101) AS converted_date
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET [date] = TRY_CONVERT(DATE, [date], 101);


--4 Remove Any Unnecessary Column

alter table layoffs_staging2
drop column row_num;

select * From layoffs_staging2;