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
 ORDER BY INVOICE.CUS_CODE 
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
 
 
 /* 
22. 
 */