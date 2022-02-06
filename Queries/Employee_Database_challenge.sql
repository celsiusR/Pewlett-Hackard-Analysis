-- -- -- -- -- -- -- 
-- Module Challenge |
-- -- -- -- -- -- -- 
select emp_no, first_name, last_name from employees;

-- Create Titles Table
CREATE TABLE titles(
  emp_no INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

select emp_no, first_name, last_name from employees;

select title, from_date, to_date from titles;
-- -- -- -- -- 
-- -- -- A query is written and executed to create a Retirement Titles table for employees 
-- -- -- who are born between January 1, 1952 and December 31, 1955.
-- -- -- -- -- 
--running this SQL for the a subsequent rune 
drop table if exists retirement_titles

-- -- Create a retirement table
select em.emp_no, em.first_name, em.last_name, t.title, t.from_date, t.to_Date
into retirement_titles
from employees as em
inner join titles as t 
on (em.emp_no = t.emp_no)
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;
-- -- 
Select * from retirement_titles;
-- -- retirement_titles Table is exported 
-- -- 
-- -- Create a unique_titles table
-- -- 
DROP TABLE if exists unique_titles;
-- -- 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no ASC, to_date DESC;
select * from unique_titles;
-- -- Export to unique_titles.csv
-- -- Export to unique_titles.csv
-- -- 
-- A query is written and executed to create a Retiring Titles table 
-- that contains the number of titles filled by employees who are retiring.
-- -- 

DROP TABLE if exists retiring_titles

SELECT COUNT(unt.emp_no),unt.title
INTO retiring_titles
FROM unique_titles as unt
GROUP BY title 
ORDER BY COUNT(title) DESC;

select * from retiring_titles;

-- -- -- -- End of Deliverable 1 -- -- -- -- -- -- -- -- 


-- -- 
-- Deliverable 2
-- -- -- -- A query is written and executed to create a Mentorship Eligibility table 
-- -- -- -- for current employees who were born between January 1, 1965 and December 31, 1965.
select emp_no, first_name, last_name, birth_date from employees;

select from_date, to_date from dept_emp;

select title from titles;

drop table if exists mentorship_eligibility;

SELECT DISTINCT ON(e.emp_no)e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

select * from mentorship_eligibility;
-- -- -- -- End of Deliverable 2 -- -- -- -- -- -- -- -- 

-- -- -- Backup for the DB





