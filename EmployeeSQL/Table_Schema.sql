-- This script perfoms the following tasks:

-- -- 1. Drop the table if it exists
-- -- 2. Create the table and its columns and primary key
-- -- 3. Create the foreign key (FK) if necessary
--------------------------------------------------------------------------------------------------------------
-- Table 'titles':

-- Remove table if it exists
DROP TABLE IF EXISTS titles;

-- Create the table
CREATE TABLE titles(
	title_id VARCHAR(30) PRIMARY KEY, 
	title VARCHAR(30) NOT NULL
);
select * from titles;
------------------------------------------------------------------------------------------------------
-- Table 'departments':

-- Remove table if it exists
DROP TABLE IF EXISTS departments;

-- Create the table
CREATE TABLE departments (
	dept_no VARCHAR(30) PRIMARY KEY,  
	dept_name VARCHAR(30) NOT NULL
);

---------------------------------------------------------------------------------------------
-- Table 'employees':

-- Remove table if it exists
DROP TABLE IF EXISTS employees;

-- date column was giving an error while importing the values from .csv file
-- ERROR: Perhaps you need a different 'datestyle' setting
-- Altered the datestyle of database to 'ISO, MDY' and imported the data from employees.csv file

SET Datestyle TO "SQL,MDY";

select '7/25/1953'::date;

ALTER DATABASE "Employee_DB" SET datestyle TO ISO, MDY;

Show Datestyle;

-- Create the table
CREATE TABLE employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_date DATE,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


select * from employees limit 5;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Table departments_employees ('dept_emp'):

-- Remove table if it exists
DROP TABLE IF EXISTS dept_emp;

-- Create the table
CREATE TABLE dept_emp (
	emp_no INTEGER,
	dept_no VARCHAR(30),  
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

select * from dept_emp limit 5;
---------------------------------------------------------------------------------------------------
-- Table 'dept_manager':

-- Remove table if it exists
DROP TABLE IF EXISTS dept_manager;

-- Create the table
CREATE TABLE dept_manager (
	dept_no VARCHAR(30), 
	emp_no INTEGER,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

select * from dept_manager;
-------------------------------------------------------------------------------------------------------
-- Table 'salaries':

-- Remove table if it exists
DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
	emp_no INTEGER, 
	salary INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

select * from salaries limit 5;