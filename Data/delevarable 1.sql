SELECT emp_no,first_name,last_name
FROM employees

SELECT title,from_date,to_date
FROM titles

SELECT  e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON (e.emp_no=t.emp_no)
WHERE(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
SELECT*FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no , to_date DESC;

--current_emp and dept_emp joining and use count groupby and orderby
SELECT COUNT(u.emp_no),u.title
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY COUNT DESC;

select * from retiring_titles