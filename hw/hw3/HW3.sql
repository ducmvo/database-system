USE ConstructCo;

/* 1 */
SELECT EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL
FROM EMPLOYEE WHERE EMP_LNAME LIKE "Smith%" ORDER BY EMP_NUM;

/* 2 */
SELECT 
PROJECT.PROJ_NAME, PROJECT.PROJ_VALUE, PROJECT.PROJ_BALANCE, 
EMPLOYEE.EMP_LNAME, EMPLOYEE.EMP_FNAME, EMPLOYEE.EMP_INITIAL,
JOB.JOB_CODE, JOB.JOB_DESCRIPTION, JOB.JOB_CHG_HOUR
FROM PROJECT JOIN JOB JOIN EMPLOYEE
ON EMPLOYEE.EMP_NUM = PROJECT.EMP_NUM AND JOB.JOB_CODE = EMPLOYEE.JOB_CODE
ORDER BY EMPLOYEE.EMP_NUM;

/* 3 */
SELECT 
PROJECT.PROJ_NAME, PROJECT.PROJ_VALUE, PROJECT.PROJ_BALANCE, 
EMPLOYEE.EMP_LNAME, EMPLOYEE.EMP_FNAME, EMPLOYEE.EMP_INITIAL,
JOB.JOB_CODE, JOB.JOB_DESCRIPTION, JOB.JOB_CHG_HOUR
FROM PROJECT JOIN EMPLOYEE JOIN JOB
ON EMPLOYEE.EMP_NUM = PROJECT.EMP_NUM 
AND JOB.JOB_CODE = EMPLOYEE.JOB_CODE
ORDER BY EMPLOYEE.EMP_LNAME;

/* 4 */
SELECT DISTINCT PROJ_NUM FROM ASSIGNMENT ORDER BY PROJ_NUM;

/* 5 */
SELECT ASSIGN_NUM, EMP_NUM, PROJ_NUM, ASSIGN_CHARGE, 
ASSIGN_CHG_HR * ASSIGN_HOURS AS CALCULATED_ASSIGN_CHG 
FROM ASSIGNMENT ORDER BY ASSIGN_NUM;

/* 
6. SQL that will yield the total number of hours worked for each employee 
and the total charges stemming from those hours worked, 
sorted by employee number
*/
SELECT ASSIGNMENT.EMP_NUM, EMPLOYEE.EMP_LNAME,
SUM(ASSIGN_HOURS) AS SumOfASSIGN_HOURS,
SUM(ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE
FROM ASSIGNMENT JOIN EMPLOYEE
ON ASSIGNMENT.EMP_NUM = EMPLOYEE.EMP_NUM
GROUP BY EMP_NUM ORDER BY EMP_NUM;


/* 
7. Write a query to produce the total number of hours and charges for each of the 
projects represented in the ASSIGNMENT table, sorted by project number. 
 */
SELECT PROJ_NUM,
SUM(ASSIGN_HOURS) AS SumOfASSIGN_HOURS,
SUM(ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE
FROM ASSIGNMENT
GROUP BY PROJ_NUM ORDER BY PROJ_NUM;

/* 
8. Write the SQL code to generate the total hours worked and the total charges made
by all employees. 
 */
SELECT 
SUM(ASSIGN_HOURS) AS SumOfASSIGN_HOURS,
SUM(ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE
FROM ASSIGNMENT;


USE SaleCo;

/* 
9. Write a query to count the number of invoices.
 */
SELECT COUNT(INV_NUMBER) from INVOICE;


/* 
10. Write a query to count the number of customers with a balance of more than $500.
 */
 SELECT COUNT(CUS_CODE) FROM CUSTOMER
 WHERE CUS_BALANCE > 500;
 
 /* 
11.  Generate a listing of all purchases made by the customers.
Sort the results by customer code, invoice number, and product description.
 */
 SELECT 
 INVOICE.CUS_CODE, INVOICE.INV_NUMBER, INVOICE.INV_DATE,
 PRODUCT.P_DESCRIPT, ROUND(LINE.LINE_UNITS) AS LINE_UNITS, LINE.LINE_PRICE
 FROM INVOICE JOIN PRODUCT JOIN LINE
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 AND PRODUCT.P_CODE = LINE.P_CODE
 ORDER BY INVOICE.CUS_CODE, INVOICE.INV_NUMBER, PRODUCT.P_DESCRIPT;
 
 /* 
12. Generate a list of customer purchases, including the subtotals for each of the invoice line numbers. 
The subtotal is a derived attribute calculated by multiplying LINE_UNITS by LINE_PRICE. 
Sort the output by customer code, invoice number, and product description.
 */
 SELECT 
 INVOICE.CUS_CODE, INVOICE.INV_NUMBER, PRODUCT.P_DESCRIPT, 
 ROUND(LINE.LINE_UNITS) AS "Unit Bought", 
 LINE.LINE_PRICE AS "Unit Price",
 ROUND(LINE.LINE_UNITS * LINE.LINE_PRICE, 2) AS "Subtotal"
 FROM INVOICE JOIN PRODUCT JOIN LINE
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 AND PRODUCT.P_CODE = LINE.P_CODE
 ORDER BY INVOICE.CUS_CODE, INVOICE.INV_NUMBER, PRODUCT.P_DESCRIPT;
 
 /* 
13. Write a query to display the customer code, balance, and total purchases for each customer. 
Total purchase is calculated by summing the line subtotals for each customer. 
Sort the results by customer code.
 */
 SELECT 
 INVOICE.CUS_CODE, CUSTOMER.CUS_BALANCE,
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Total Purchases"
 FROM INVOICE JOIN LINE JOIN CUSTOMER
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 AND INVOICE.CUS_CODE = CUSTOMER.CUS_CODE
 GROUP BY INVOICE.CUS_CODE
 ORDER BY INVOICE.CUS_CODE;
 
 /* 
14. Modify the query in Problem 13 to include the number of individual product purchases made by each customer. 
 */
 SELECT 
 INVOICE.CUS_CODE, CUSTOMER.CUS_BALANCE,
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Total Purchases",
 COUNT(LINE.LINE_NUMBER) AS "Number of Purchases"
 FROM INVOICE JOIN LINE JOIN CUSTOMER
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 AND INVOICE.CUS_CODE = CUSTOMER.CUS_CODE
 GROUP BY INVOICE.CUS_CODE
 ORDER BY INVOICE.CUS_CODE; 

 
 /* 
15. 
Use a query to compute the total of all purchases, the number of purchases, 
and the average purchase amount made by each customer.
 */
 SELECT 
 INVOICE.CUS_CODE, CUSTOMER.CUS_BALANCE,
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Total Purchases",
 COUNT(LINE.LINE_NUMBER) AS "Number of Purchases",
 ROUND(AVG(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Average Purchase Amount"
 FROM INVOICE JOIN LINE JOIN CUSTOMER
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 AND INVOICE.CUS_CODE = CUSTOMER.CUS_CODE
 GROUP BY INVOICE.CUS_CODE
 ORDER BY INVOICE.CUS_CODE; 
 
 /* 
16. Create a query to produce the total purchase per invoice, sorted by invoice number.
 */
 SELECT
 INVOICE.INV_NUMBER,
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Invoice Total"
 FROM INVOICE JOIN LINE
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 GROUP BY INVOICE.INV_NUMBER
 ORDER BY INVOICE.INV_NUMBER;
 
 /* 
17. Use a query to show the invoices and invoice totals in.
Sort the results by customer code and then by invoice number.
 */
 SELECT
 INVOICE.CUS_CODE, INVOICE.INV_NUMBER,
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Invoice Total"
 FROM INVOICE JOIN LINE
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 GROUP BY INVOICE.INV_NUMBER
 ORDER BY INVOICE.CUS_CODE, INVOICE.INV_NUMBER;
 
 
 /* 
18. Write a query to produce the number of invoices and the total purchase amounts by customer, 
the results are sorted by customer code.
 */
 SELECT 
 INVOICE.CUS_CODE,
 COUNT(INVOICE.INV_NUMBER) AS "Number of Invoices",
 ROUND(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE), 2) AS "Total Customer Purchases"
 FROM INVOICE JOIN LINE
 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
 GROUP BY INVOICE.CUS_CODE
 ORDER BY INVOICE.CUS_CODE; 
 
 
 /* 
19. Write a query to generate the total number of invoices, 
the invoice total for all of the invoices, the smallest of the customer purchase amounts, 
the largest of the customer purchase amounts, 
and the average of all the customer purchase amounts.
 */
--  SELECT 
--  COUNT(INVOICE.INV_NUMBER),
--  SUM(LINE_UNITS * LINE_PRICE)
--  FROM INVOICE JOIN LINE
--  WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER;

SELECT 
SUM(Invoices) as "Total Invoices",
SUM(Purchases) as "Total Sales",
MAX(Purchases) as "Largest Customer Purchases", 
MIN(Purchases) as "Minimun Customer Purchases",
ROUND(AVG(Purchases),2) as "Average Customer Purchases" 
FROM (
	 SELECT
	 ROUND(SUM(LINE_UNITS * LINE_PRICE),2) AS Purchases,
	 COUNT(DISTINCT INVOICE.INV_NUMBER) AS Invoices
	 FROM INVOICE JOIN LINE
	 WHERE INVOICE.INV_NUMBER = LINE.INV_NUMBER
	 GROUP BY INVOICE.CUS_CODE
) AS CUSTOMERSALES; 
 
 /* 
20. List the balances of customers who have made purchases during the current invoice cycle 
that is, for the customers who appear in the INVOICE table, sorted by customer code. 
 */
 SELECT
 INVOICE.CUS_CODE, CUSTOMER.CUS_BALANCE
 FROM INVOICE JOIN CUSTOMER 
 WHERE INVOICE.CUS_CODE = CUSTOMER.CUS_CODE
 GROUP BY INVOICE.CUS_CODE
 ORDER BY INVOICE.CUS_CODE;
 
 
 /* 
21. 
 */
 SELECT 
 MIN(CUS_BALANCE) AS "Minimum Balance",
 MAX(CUS_BALANCE) AS "Maxmimum Balance",
 ROUND(AVG(CUS_BALANCE),2) AS "Average Balance"
 FROM (
	 SELECT
	 INVOICE.CUS_CODE, CUSTOMER.CUS_BALANCE
	 FROM INVOICE JOIN CUSTOMER 
	 WHERE INVOICE.CUS_CODE = CUSTOMER.CUS_CODE
	 GROUP BY INVOICE.CUS_CODE
) AS CUSTOMERBALANCES;
 
 
 /* 
22. Create a query to find the balance characteristics for all customers, 
including the total of the outstanding balances. 
 */
 SELECT 
 SUM(CUS_BALANCE) AS "Total Balance",
 MIN(CUS_BALANCE) AS "Minimum Balance",
 MAX(CUS_BALANCE) AS "Maximum Balance",
 ROUND(AVG(CUS_BALANCE),2) AS "Average Balance"
 FROM CUSTOMER;
 
/* 
23.Find the listing of customers who 
did not make purchases during the invoicing period. 
Sort the results by customer code.  
 */
SELECT CUSTOMER.CUS_CODE, CUS_BALANCE
FROM INVOICE RIGHT OUTER JOIN CUSTOMER
ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
WHERE INV_NUMBER IS NULL
ORDER BY CUSTOMER.CUS_CODE;


/* 
24. Create a query that summarizes the value of products currently in inventory. 
Note that the value of each product is a result of multiplying the units 
currently in inventory by the unit price. 
Sort the results in descending order by subtotal, 
 */
SELECT P_DESCRIPT, P_QOH, P_PRICE, 
(P_QOH * P_PRICE) AS Subtotal
FROM PRODUCT
ORDER BY Subtotal DESC;

/* 
25.
 */
SELECT SUM(P_QOH * P_PRICE) AS "Total Value Inventory"
FROM PRODUCT;


USE LargeCo;
-- 27. Write a query to display the eight departments in the LGDEPARTMENT table sorted by department name.
SELECT * FROM LGDEPARTMENT ORDER BY DEPT_NAME;

-- 28. Write a query to display the SKU (stock keeping unit), description, type, base, cat- egory, 
-- and price for all products that have a PROD_BASE of Water and a PROD_CATEGORY of Sealer
SELECT PROD_SKU, PROD_DESCRIPT,PROD_TYPE,PROD_BASE, PROD_CATEGORY,PROD_PRICE FROM LGPRODUCT
WHERE PROD_BASE="Water" AND PROD_CATEGORY = "Sealer"; 

/* 29. Write a query to display the first name, last name, and email address of employees 
hired from January 1, 2005, to December 31, 2014. 
Sort the output by last name and then by first name */
SELECT EMP_FNAME, EMP_LNAME, EMP_EMAIL FROM LGEMPLOYEE
WHERE EMP_HIREDATE BETWEEN "2005-1-1" AND "2014-12-31"
ORDER BY EMP_LNAME, EMP_FNAME;

/* 
30. Writeaquerytodisplaythe firstname,lastname,phonenumber,title,and department number of employees 
who work in department 300 or have the title “CLERK I.” 
Sort the output by last name and then by first name
*/
SELECT EMP_FNAME, EMP_LNAME, EMP_PHONE, EMP_TITLE, DEPT_NUM
FROM LGEMPLOYEE 
WHERE DEPT_NUM = 300 OR EMP_TITLE = "CLERK I"
ORDER BY EMP_LNAME, EMP_FNAME;
-- JOIN LGDEPARTMENT
-- WHERE LGEMPLOYEE.EMP_NUM = LGDEPARTMENT.EMP_NUM

/* 
31. Write a query to display the employee number, lastname, firstname,
salary“from” date, salary end date, and salary amount 
for employees 83731, 83745, and 84039. 
Sort the output by employee number and salary “from” date
*/
SELECT LGEMPLOYEE.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_FROM, SAL_END, SAL_AMOUNT
FROM LGEMPLOYEE JOIN LGSALARY_HISTORY
ON LGEMPLOYEE.EMP_NUM = LGSALARY_HISTORY.EMP_NUM
WHERE LGEMPLOYEE.EMP_NUM = 83731 OR LGEMPLOYEE.EMP_NUM = 83745
OR LGEMPLOYEE.EMP_NUM = 84039
ORDER BY LGEMPLOYEE.EMP_NUM, SAL_FROM;

/* 
32.Writeaquerytodisplaythe
firstname,lastname,street,city,state,and zipcode
of any customer who purchased a Foresters Best brand top coat 
between July 15, 2015, and July 31, 2015. 
If a customer purchased more than one such product, 
display the customer’s information only once in the output. 
Sort the output by state, last name, and then first name (Figure P7.32).
*/
SELECT CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE, CUST_ZIP
FROM LGCUSTOMER 
JOIN LGINVOICE JOIN LGLINE JOIN LGPRODUCT
ON LGCUSTOMER.CUST_CODE = LGINVOICE.CUST_CODE
AND LGINVOICE.INV_NUM = LGLINE.INV_NUM
AND LGLINE.PROD_SKU = LGPRODUCT.PROD_SKU
WHERE PROD_CATEGORY = "Top Coat"
AND INV_DATE BETWEEN '2017-07-15' AND '2017-07-31'
GROUP BY LGCUSTOMER.CUST_CODE
ORDER BY CUST_STATE, CUST_FNAME, CUST_LNAME;


 /* 
33. Write a query to display the employee number, last name, email address, title, 
and department name of each employee 
whose job title ends in the word “ASSOCIATE.”
 Sort the output by department name and employee title
*/

SELECT LGEMPLOYEE.EMP_NUM, EMP_LNAME, EMP_EMAIL, EMP_TITLE, DEPT_NAME
FROM LGEMPLOYEE JOIN LGDEPARTMENT
ON LGEMPLOYEE.DEPT_NUM = LGDEPARTMENT.DEPT_NUM
WHERE EMP_TITLE LIKE "%ASSOCIATE"
ORDER BY DEPT_NAME, EMP_TITLE;

/*
34. Write a query to display a brand name and 
the number of products of that brand that are in the database. 
Sort the output by the brand name
*/
SELECT BRAND_NAME, COUNT(PROD_SKU) AS NUMPRODUCTS
FROM LGPRODUCT JOIN LGBRAND
ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
GROUP BY LGBRAND.BRAND_ID
ORDER BY LGBRAND.BRAND_NAME;

/*
35.
Writeaquerytodisplaythe
number of products in each category
that havea water base, 
sorted by category.
*/
SELECT PROD_CATEGORY, COUNT(PROD_SKU) AS NUMPRODUCTS
FROM LGPRODUCT
WHERE PROD_BASE = "Water"
GROUP BY PROD_CATEGORY 
ORDER BY PROD_CATEGORY;


/* 
35. Writea query to display the
number of products
within each base and type combination, 
sorted by base and then by type
*/
SELECT PROD_BASE, PROD_TYPE, COUNT(PROD_SKU) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE, PROD_TYPE
ORDER BY PROD_BASE, PROD_TYPE;


/*
37. Write a query to display the 
total inventory that is, 
the sum of all products on hand for each brand ID. 
Sort the output by brand ID in descending order 
*/
SELECT LGBRAND.BRAND_ID, SUM(PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT JOIN LGBRAND
ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
GROUP BY LGBRAND.BRAND_ID
ORDER BY LGBRAND.BRAND_ID DESC;

/* 
38. Write a query to display the 
brand ID, brand name, and average price of products of each brand. 
Sort the output by brand name. 
Results are shown with the average price rounded to two decimal places (Figure P7.38).
*/
SELECT LGBRAND.BRAND_ID, LGBRAND.BRAND_NAME, 
ROUND(AVG(PROD_PRICE),2) AS AVGPRICE
FROM LGPRODUCT JOIN LGBRAND
ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
GROUP BY LGBRAND.BRAND_ID
ORDER BY LGBRAND.BRAND_NAME;

/*
39. Write a query to display the department number and most recent employee hire date for each department. 
Sort the output by department number (Figure P7.39).
*/
SELECT DEPT_NUM, MAX(EMP_HIREDATE) AS MOSTRECENT
FROM LGEMPLOYEE
GROUP BY DEPT_NUM;

/*
40. Write a query to display 
the employee number, first name, last name, and largest salary amount 
for each employee in department 200. 
Sort the output by largest salary in descending order (Figure P7.40).
*/
SELECT LGEMPLOYEE.EMP_NUM, EMP_FNAME, EMP_LNAME, MAX(SAL_AMOUNT) AS LARGESTSALARY
FROM LGEMPLOYEE JOIN LGSALARY_HISTORY
ON LGEMPLOYEE.EMP_NUM = LGSALARY_HISTORY.EMP_NUM
WHERE DEPT_NUM = 200
GROUP BY LGEMPLOYEE.EMP_NUM
ORDER BY LARGESTSALARY DESC;

/*
41. Write a query to display 
the customer code, first name, last name, and sum of all invoice totals 
for customers with cumulative invoice totals greater than $1,500. 
Sort the output by the sum of invoice totals in descending order (Figure P7.41).
*/
SELECT
LGCUSTOMER.CUST_CODE, CUST_FNAME, CUST_LNAME, 
SUM(INV_TOTAL) AS TOTALINVOICES
FROM LGCUSTOMER JOIN LGINVOICE
ON LGCUSTOMER.CUST_CODE = LGINVOICE.CUST_CODE
GROUP BY LGCUSTOMER.CUST_CODE
HAVING TOTALINVOICES > 1500
ORDER BY TOTALINVOICES DESC;

/*
42. Write a query to display 
the department number, department name, department phone number, employee number, 
and last name of each department manager. 
Sort the output by department name.
*/
SELECT LGDEPARTMENT.DEPT_NUM, DEPT_NAME, DEPT_PHONE, LGEMPLOYEE.EMP_NUM, EMP_LNAME
FROM LGDEPARTMENT JOIN LGEMPLOYEE 
ON LGDEPARTMENT.EMP_NUM = LGEMPLOYEE.EMP_NUM
ORDER BY DEPT_NAME;

/*
43. Write a query to display the vendor ID, vendor name, brand name,
and number of products of each brand supplied by each vendor. 
Sort the output by vendor name and then by brand name (Figure P7.43).
*/

SELECT LGVENDOR.VEND_ID, VEND_NAME, BRAND_NAME, 
COUNT(LGPRODUCT.PROD_SKU) AS NUMPRODUCTS
FROM LGVENDOR
JOIN LGSUPPLIES ON LGVENDOR.VEND_ID = LGSUPPLIES.VEND_ID
JOIN LGPRODUCT ON LGSUPPLIES.PROD_SKU = LGPRODUCT.PROD_SKU
JOIN LGBRAND ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
GROUP BY LGVENDOR.VEND_ID, LGBRAND.BRAND_ID
ORDER BY VEND_NAME, BRAND_NAME;

/*
44. Write a query to display the employee number, last name, first name, 
and sum of invoice totals for all employees who completed an invoice. 
Sort the output by employee last name and then by first name (Figure P7.44).
*/

SELECT LGEMPLOYEE.EMP_NUM, EMP_LNAME, EMP_FNAME,
SUM(LGINVOICE.INV_TOTAL) AS TOTALINVOICES
FROM LGEMPLOYEE JOIN LGINVOICE
ON LGEMPLOYEE.EMP_NUM = LGINVOICE.EMPLOYEE_ID
GROUP BY LGEMPLOYEE.EMP_NUM
ORDER BY EMP_LNAME, EMP_FNAME;

/*
45.  Write a query to display the largest average product price of any brand.
*/
SELECT MAX(AVGBRANDPRICE) AS `LARGEST AVERAGE` FROM (
	SELECT ROUND(AVG(LGPRODUCT.PROD_PRICE),2) AS AVGBRANDPRICE
	FROM LGPRODUCT
	JOIN LGBRAND ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
	GROUP BY LGBRAND.BRAND_ID
) AS AVGPRICE;


/*
46. Write a query to display the brand ID, brand name, brand type, 
and average price of products for the brand 
that has the largest average product price .
*/

SELECT LGBRAND.BRAND_ID, BRAND_NAME, BRAND_TYPE, 
AVG(LGPRODUCT.PROD_PRICE) AS AVERAGE
FROM LGPRODUCT JOIN LGBRAND 
ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
GROUP BY LGBRAND.BRAND_ID
HAVING AVERAGE = (
	SELECT MAX(AVGBRANDPRICE) FROM (
		SELECT AVG(LGPRODUCT.PROD_PRICE) AS AVGBRANDPRICE
		FROM LGPRODUCT
		JOIN LGBRAND ON LGPRODUCT.BRAND_ID = LGBRAND.BRAND_ID
		GROUP BY LGBRAND.BRAND_ID
	) AS AVGPRICE
);

/*
47. Write a query to display the manager name, department name, department phone number, 
employee name, customer name, invoice date, and invoice total 
for the department manager of the employee who made a sale to 
a customer whose last name is Hagan on May 18, 2015.
*/
SELECT 
EMP_FNAME AS MANAGER_FNAME,
EMP_LNAME AS MANAGER_LNAME,
DEPT_NAME, DEPT_PHONE
FROM LGEMPLOYEE JOIN LGDEPARTMENT
ON LGEMPLOYEE.EMP_NUM = LGEMPLOYEE.EMP_NUM
;



SELECT
MANAGER_FNAME, MANAGER_LNAME,
DEPT_NAME, DEPT_PHONE,
EMP_FNAME,EMP_LNAME,
CUST_FNAME,CUST_LNAME,
INV_DATE, INV_TOTAL
FROM LGINVOICE
JOIN LGCUSTOMER ON LGINVOICE.CUST_CODE = LGCUSTOMER.CUST_CODE
JOIN LGEMPLOYEE ON LGINVOICE.EMPLOYEE_ID = LGEMPLOYEE.EMP_NUM
JOIN LGDEPARTMENT ON LGEMPLOYEE.DEPT_NUM = LGDEPARTMENT.DEPT_NUM
JOIN (
	SELECT
	EMP_NUM AS MANAGER_NUM,
	EMP_FNAME AS MANAGER_FNAME,
	EMP_LNAME AS MANAGER_LNAME
	FROM LGEMPLOYEE
) AS LGMANAGER ON LGMANAGER.MANAGER_NUM = LGDEPARTMENT.EMP_NUM
WHERE CUST_LNAME = "Hagan" AND INV_DATE = "2017-05-18";

/*
48. Write a query to display the current salary for each employee in department 300. 
Assume that only current employees are kept in the system, 
and therefore the most current salary for each employee is the entry in the salary history with a NULL end date. 
Sort the output in descending order by salary amount (Figure P7.48).
*/
SELECT LGEMPLOYEE.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
FROM LGEMPLOYEE JOIN LGSALARY_HISTORY
ON LGEMPLOYEE.EMP_NUM = LGSALARY_HISTORY.EMP_NUM
WHERE DEPT_NUM = 300 AND SAL_END IS NULL
ORDER BY SAL_AMOUNT DESC;


/* 
49. Write a query to display the starting salary for each employee. 
The starting salary would be the entry in the salary history with the oldest salary start date for each employee. 
Sort the output by employee number (Figure P7.49).
*/

SELECT DISTINCT LGEMPLOYEE.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
FROM LGEMPLOYEE JOIN LGSALARY_HISTORY
ON LGEMPLOYEE.EMP_NUM = LGSALARY_HISTORY.EMP_NUM
JOIN (
	SELECT LGEMPLOYEE.EMP_NUM, MIN(SAL_FROM) AS STARTDATE
	FROM LGEMPLOYEE JOIN LGSALARY_HISTORY
	ON LGEMPLOYEE.EMP_NUM = LGSALARY_HISTORY.EMP_NUM
	GROUP BY LGEMPLOYEE.EMP_NUM
) AS SAL_START 
ON SAL_FROM = SAL_START.STARTDATE AND LGEMPLOYEE.EMP_NUM = SAL_START.EMP_NUM;


/*
Write a query to display the employee number, employee first name, employee last name, email address, 
and total units sold for the employee who sold the most Binder Prime brand products between November 1, 2015, and December 5, 2015. 
If there is a tie for most units sold, sort the output by employee last name
*/
SELECT EMP_NUM, EMP_FNAME,EMP_LNAME, EMP_EMAIL, COUNT(LGINVOICE.INV_NUM) AS TOTALINVOICE
FROM LGEMPLOYEE
JOIN LGINVOICE ON LGINVOICE.EMPLOYEE_ID = LGEMPLOYEE.EMP_NUM
JOIN LGLINE ON LGINVOICE.INV_NUM = LGLINE.INV_NUM
JOIN LGPRODUCT ON LGLINE.PROD_SKU = LGPRODUCT.PROD_SKU
JOIN LGBRAND ON LGBRAND.BRAND_ID = LGPRODUCT.BRAND_ID
WHERE BRAND_NAME = "BINDER PRIME"
GROUP BY EMP_NUM
HAVING TOTALINVOICE = (
	SELECT MAX(TOTALINVOICE) FROM (
		SELECT COUNT(LGINVOICE.INV_NUM) AS TOTALINVOICE
		FROM LGEMPLOYEE
		JOIN LGINVOICE ON LGINVOICE.EMPLOYEE_ID = LGEMPLOYEE.EMP_NUM
		JOIN LGLINE ON LGINVOICE.INV_NUM = LGLINE.INV_NUM
		JOIN LGPRODUCT ON LGLINE.PROD_SKU = LGPRODUCT.PROD_SKU
		JOIN LGBRAND ON LGBRAND.BRAND_ID = LGPRODUCT.BRAND_ID
		WHERE BRAND_NAME = "BINDER PRIME"
		GROUP BY EMP_NUM
	) AS MAXTV
)
ORDER BY EMP_LNAME;


