--creating a tables for PH-EmployeeDb

CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name  VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);


CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager(
dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
    emp_no INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, title, from_date)
);
	
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

SELECT * FROM employees

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' and '1955-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' and '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' and '1953-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' and '1954-12-31';

SELECT first_name,last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' and '1955-12-31';

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--recreate retirement info

DROP table retirement_info;

SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

SELECT *FROM retirement_info


--join departments and dept_manager table
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no=dept_manager.dept_no;

--creating above query with the aliases
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;

--join retirement_info and dept_emp
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no=dept_emp.emp_no;

--use aliase for table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no;

--performing left join on retirement_info and dept_emp and save output as current_emp
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
from retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no
WHERE de.to_date=('9999-01-01');

select * from current_emp

--current_emp and dept_emp joining and use count groupby and orderby
SELECT COUNT(ce.emp_no),de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no;

--how many employees are leaving from department(employee count by dept_no)
SELECT COUNT(ce.emp_no),de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--create new table for output 
SELECT COUNT(ce.emp_no),de.dept_no
INTO dept_re_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP  BY de.dept_no
ORDER BY de.dept_no;

--latest date on salry table
select*from salaries
ORDER BY to_date DESC

--craeting new emp_info(updating version of retirement_info) table

SELECT emp_no,first_name,last_name,gender,birth_date,hire_date
INTO emp_info1
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT* FROM emp_info1

--join emp_info and salary table
SELECT e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM emp_info1 as e
INNER JOIN salaries as s
ON (e.emp_no=s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
WHERE(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND(e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
select * from emp_info

--list of manager per department

SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments as d
ON (dm.dept_no=d.dept_no)
INNER JOIN current_emp as ce
ON (dm.emp_no=ce.emp_no);
SELECT*FROM manager_info

select*from current_emp

--add department name in current emp
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no);
select * from dept_info

select* from retirement_info

--create new table only sales info 
SELECT re.emp_no,
	re.first_name,
	re.last_name,
	d.dept_name
into info_1
FROM retirement_info as re
INNER JOIN dept_emp as de
ON (re.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no)
WHERE(dept_name='Sales');
	
--data sales and development
SELECT re.emp_no,
	re.first_name,
	re.last_name,
	d.dept_name
into info_1
FROM retirement_info as re
INNER JOIN dept_emp as de
ON (re.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no)
WHERE dept_name IN ('Sales','Development')