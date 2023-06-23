CREATE DATABASE projects;

SELECT * FROM hr;

# Changed incorrect column name to emp_id
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20)NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

# Changed incorrect date format for birthdate column
UPDATE hr
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%'THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%'THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

# Modified birthdate datatype from text to date
ALTER TABLE hr
MODIFY COLUMN birthdate DATE 
SELECT birthdate FROM hr;

# Changed incorrect date format for hiredate column
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%'THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%'THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

# Modified hiredate datatype from text to date
ALTER TABLE hr
MODIFY COLUMN hire_date DATE 
SELECT hire_date FROM hr;

# Changed date-time format for termdate column to date format
SET sql_mode = 'ALLOW_INVALID_DATES';
UPDATE hr
SET termdate =  COALESCE(date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE termdate IS NOT NULL OR termdate != '';

# Modified termdate datatype from text to date
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

# added an age column
ALTER TABLE hr ADD COLUMN age INT;

# Subtracted birthdate from current date to get the age of each row
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());
SELECT birthdate, age FROM hr;

# Selecting the youngest and oldest ages
SELECT min(age) AS youngest,
	   max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age <18;