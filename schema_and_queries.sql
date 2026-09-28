CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    department VARCHAR(100) NOT NULL,
    manager VARCHAR(100)
);

CREATE TABLE employees (
    employee_id VARCHAR(10) PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id VARCHAR(10) REFERENCES departments(department_id),
    job_level VARCHAR(30),
    location VARCHAR(50)
);

CREATE TABLE expense_categories (
    category_id VARCHAR(10) PRIMARY KEY,
    expense_category VARCHAR(100) NOT NULL,
    typical_limit NUMERIC(12,2)
);

CREATE TABLE expense_claims (
    claim_id VARCHAR(20) PRIMARY KEY,
    employee_id VARCHAR(10) REFERENCES employees(employee_id),
    category_id VARCHAR(10) REFERENCES expense_categories(category_id),
    claim_date DATE,
    amount NUMERIC(12,2),
    payment_method VARCHAR(50),
    status VARCHAR(30),
    approval_days NUMERIC,
    reimbursement_days NUMERIC,
    description TEXT
);

-- Example analysis queries
-- 1. Total expense by department
SELECT d.department, SUM(c.amount) AS total_expense
FROM expense_claims c
JOIN employees e ON c.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department
ORDER BY total_expense DESC;

-- 2. Pending claims
SELECT COUNT(*) AS pending_claims,
       SUM(amount) AS pending_amount
FROM expense_claims
WHERE status = 'Pending';

-- 3. Average reimbursement time by department
SELECT d.department,
       ROUND(AVG(c.reimbursement_days), 2) AS avg_reimbursement_days
FROM expense_claims c
JOIN employees e ON c.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE c.status = 'Paid'
GROUP BY d.department
ORDER BY avg_reimbursement_days DESC;

-- 4. Expense by category
SELECT ec.expense_category,
       COUNT(*) AS claims,
       ROUND(SUM(c.amount), 2) AS total_expense
FROM expense_claims c
JOIN expense_categories ec ON c.category_id = ec.category_id
GROUP BY ec.expense_category
ORDER BY total_expense DESC;