-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
select employees.first_name, employees.last_name, employees.hire_date
FROM employees
where hire_date >= '1986-01-01'
and hire_date < '1987-01-01'

-- 3.List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.
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

--4.List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.
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

--5. List first name, last name, and sex of each employee whose first name is Hercules and 
--whose last name begins with the letter B.
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
	
--6.List each employee in the Sales department, including their employee number, last name,
--and first name.
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

--OR
SELECT 
	e.emp_no,
	e.last_name,
	e.first_name
FROM 
	employees e
	WHERE e.emp_no in (SELECT de.emp_no 
				 FROM dept_emp de 
				 JOIN departments d ON d.dept_no = de.dept_no
				 WHERE d.dept_name = 'Sales');
				 
--7. List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
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
	
--8. List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).
 
SELECT
	last_name,
	Count (*) as frequency
FROM 
	employees
	GROUP BY last_name
ORDER BY frequency DESC;



	
	
