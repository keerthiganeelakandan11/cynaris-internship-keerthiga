/*
    Cynaris Internship
    Week 1 - Day 2
    Topic: SQL JOINs

    Topics covered:
    1. INNER JOIN
    2. LEFT JOIN
    3. RIGHT JOIN
    4. FULL OUTER JOIN
    5. Duplicate rows caused by JOINs
    6. SELF JOIN
    7. Table aliases
*/


-- ============================================================
-- SAMPLE TABLES
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10, 2)
);



INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'Data Analytics'),
    (2, 'Engineering'),
    (3, 'Human Resources'),
    (4, 'Finance');

INSERT INTO employees (
    employee_id,
    employee_name,
    department_id,
    manager_id,
    salary
)
VALUES
    (101, 'Anitha', 1, NULL, 60000),
    (102, 'Rahul', 1, 101, 45000),
    (103, 'Priya', 2, NULL, 70000),
    (104, 'Karthik', 2, 103, 50000),
    (105, 'Divya', 3, NULL, 55000),
    (106, NULL, NULL, NULL, NULL);



-- 1. INNER JOIN

-- Returns only employees whose department exists
-- in the departments table.

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id;



-- 2. LEFT JOIN

-- Returns ALL employees.
-- If an employee does not have a matching department,
-- department_name will be NULL.

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees AS e
LEFT JOIN departments AS d
    ON e.department_id = d.department_id;



-- 3. RIGHT JOIN

-- Returns ALL departments.
-- If a department has no employees,
-- employee_name will be NULL.

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees AS e
RIGHT JOIN departments AS d
    ON e.department_id = d.department_id;


-- 4. FULL OUTER JOIN

-- Returns all matching and non-matching rows
-- from both tables.

SELECT
    e.employee_id,
    e.employee_name,
    d.department_name
FROM employees AS e
FULL OUTER JOIN departments AS d
    ON e.department_id = d.department_id;


-- 5. DUPLICATE ROWS CAUSED BY JOINs

-- Duplicate-looking rows can occur when one row in one table
-- matches multiple rows in the other table.
--
-- The JOIN itself is not necessarily wrong.
-- It may represent a one-to-many relationship.


SELECT
    d.department_name,
    e.employee_name
FROM departments AS d
INNER JOIN employees AS e
    ON d.department_id = e.department_id;


-- To count employees correctly by department:

SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;


-- ============================================================
-- 6. SELF JOIN
-- ============================================================
-- A SELF JOIN joins a table with itself.
--
-- Here we use manager_id to find each employee's manager.


SELECT
    e.employee_name AS employee_name,
    m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- 7. SELF JOIN - FIND EMPLOYEES WHO EARN MORE THAN THEIR MANAGER
-- ============================================================

SELECT
    e.employee_name AS employee_name,
    e.salary AS employee_salary,
    m.employee_name AS manager_name,
    m.salary AS manager_salary
FROM employees AS e
INNER JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;


-- ============================================================
-- 8. USING TABLE ALIASES
-- ============================================================
-- e = employees
-- d = departments
--
-- Aliases make JOIN queries shorter and easier to read.


SELECT
    e.employee_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id
WHERE e.salary >= 50000;