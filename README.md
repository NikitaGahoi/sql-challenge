
# SQL-Challenge

Conduct research on employees working in the 1980s and 1990s at the company Pewlett Hackard. The only data that remains from the time period are 6 CSV files.

## Objective
Perform data modeling, data engineering, and data analysis by designing the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. 

## Data Modelling
After inspecting the CSVs, create an ERD using Quick Database Diagrams.

![ERD_Employee_DB](https://github.com/NikitaGahoi/sql-challenge/assets/136101293/09c6f9c6-6ed9-4f84-a1f3-fb8c9ced2426)

## Data Engineering
Create a table schema for each of the 6 CSV files with specific data types, primary keys, foreign keys, and constraints.

```postgres
-- Create the table titles:
CREATE TABLE titles(
	title_id VARCHAR(30) PRIMARY KEY, 
	title VARCHAR(30) NOT NULL
);
-------------------------------------------------
--Create the table departments:
CREATE TABLE departments (
	dept_no VARCHAR(30) PRIMARY KEY,  
	dept_name VARCHAR(30) NOT NULL
);
-------------------------------------------------
ALTER DATABASE "Employee_DB" SET datestyle TO ISO, MDY;
Show Datestyle;

-- Create the table employees:
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
--------------------------------------------------
-- Create the table departments_employees (dept_emp):
CREATE TABLE dept_emp (
	emp_no INTEGER,
	dept_no VARCHAR(30),  
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
------------------------------------------------- 
-- Create the table dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR(30), 
	emp_no INTEGER,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
--------------------------------------------------
-- Create the table salaries:
CREATE TABLE salaries (
	emp_no INTEGER, 
	salary INTEGER,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
```
## Data Analysis
1. List the employee number, last name, first name, sex, and salary of each employee
```postgres
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no;
```
2. List the first name, last name, and hire date for the employees who were hired in 1986.
```postgres
select employees.first_name, employees.last_name, employees.hire_date
FROM employees
where hire_date >= '1986-01-01'
and hire_date < '1987-01-01'
```
3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
```postgres
SELECT 
	dm.dept_no,
	dm.emp_no,
	d.dept_name,
	e.first_name,
	e.last_name
FROM
	dept_manager dm
INNER JOIN departments d ON dm.dept_no = d.dept_no
INNER JOIN employees e ON dm.emp_no = e.emp_no;
```
4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
```postgres
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	de.dept_no,
	d.dept_name
FROM
	dept_emp de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;
```
5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
```postgres
SELECT
	first_name,
	last_name,
	sex
FROM
	employees
WHERE
	first_name='Hercules'
	AND
	last_name LIKE 'B%';
```
6. List each employee in the Sales department, including their employee number, last name, and first name.
```postgres
SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	de.dept_no,
	d.dept_name
FROM
	dept_emp de
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
```
7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
```postgres
SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM
	employees e	
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE (d.dept_name = 'Sales' 
	OR d.dept_name = 'Development');
```
8. List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).
```postgres 
SELECT
	last_name,
	Count (*) as frequency
FROM 
	employees
	GROUP BY last_name
ORDER BY frequency DESC;
```


