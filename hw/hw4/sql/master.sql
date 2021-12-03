-- Master.SQL Contains a variety of different SQL Statements. 
-- This is geared for ch08_salesco
-- If you are using a different database, try to make similar queries that make sense
-- The goal is to use the different SQL Syntax. You should not have to overthink this. Please just try to 
-- do a similar query.
-- Puts comments above the query to signify which one you are doing.alter
-- Try running 



use ch08_saleco;

-- Normal Join  Query #1  (MY PREFERENCE)
select p_code, p_descript, p_price, v_name
from product, vendor
where product.v_code = vendor.v_code;


-- SHORT CUT (NATURAL JOIN)
select cus_code, cus_lname, inv_number, inv_date
from customer natural join invoice;

-- SHORT CUTS JOIN USING
select inv_number, p_code, p_descript, line_units, line_price
from invoice join line using (INV_NUMBER) join product using (P_CODE);

-- JOIN ON (HAVE TO USE ACTUAL JOIN COLUMNS)
select invoice.inv_number, product.p_code, p_descript, line_units, line_price
from invoice join line on invoice.inv_number = line.inv_number
join product on line.p_code=product.p_code;
-- join ON
select e.emp_mgr, m.emp_lname, e.emp_num, e.emp_lname
from emp e join emp m on e.emp_mgr = m.emp_num
order by e.emp_mgr;


-- Left Outer Join (VENDORS who don't have PRODUCTS will show up)
select p_code, vendor.v_code, v_name
from vendor left join product on vendor.v_code = product.v_code;

-- Right Outer Join ()
select p_code, vendor.v_code, v_name
from vendor right join product on vendor.v_code = product.v_code;

-- subqueries

select inv_number, invoice.cus_code, cus_lname, cus_fname
from customer, invoice
where customer.cus_code = invoice.cus_code;

-- Subquery doesn't work
select v_code
from vendor 
where not exists (select v_code from product where vendor.v_code = product.v_code);


-- subquery with where    AWESOME QUERY
select p_code, p_price from product
where p_price>=(select avg(p_price) from product);

-- subquery with where 
select distinct cus_code, cus_lname, cus_fname
from customer join invoice using (cus_code)
join line using (INV_NUMBER)
join product using (P_CODE)
where p_code = (select p_code from product where p_descript='claw hammer');

-- Similar
select distinct cus_code, cus_lname, cus_fname
from customer join invoice using (cus_code)
join line using (INV_NUMBER)
join product using (P_CODE)
where p_descript='claw hammer';

-- in SubQueries
select distinct cus_code, cus_lname, cus_fname
from customer join invoice using (cus_code)
join line using (inv_number)
join product using (p_code)
where p_code in (select p_code from product
					where p_descript like '%hammer%'
					or p_descript like '%saw%');
                    
-- in SubQueries  (SAME)
select distinct cus_code, cus_lname, cus_fname
from customer join invoice using (cus_code)
join line using (inv_number)
join product using (p_code)
where p_descript like '%hammer%'
					or p_descript like '%saw%';
                    
-- subquery HAVING
select p_code, sum(LINE_UNITS), AVG(LINE_UNITS)
from line
group by p_code
-- where sum(LINE_UNITS) > AVG(LINE_UNITS); -- Can't do this, that is why having
having sum(LINE_UNITS) > (SELECT AVG(LINE_UNITS) from LINE);

-- subquery ALL AND ANY
select p_code, p_qoh*p_price
from product
where p_qoh*p_price > ALL(SELECT P_QOH * P_PRICE
						from product 
						where v_code in (select v_code
                        from vendor
                        where v_state='FL'));

-- subquery ANY (DOESN'T Really make sense does it?)
select p_code, p_qoh*p_price
from product
where p_qoh*p_price > ANY(SELECT P_QOH * P_PRICE
						from product 
						where v_code in (select v_code
                        from vendor
                        where v_state='FL'));                        
                        
                        
-- FROM SUBQUERIES
select distinct customer.cus_code, customer.cus_lname 
from customer,
	(select invoice.cus_code from invoice natural join line
    where p_code='13-Q2/P2') CP1,
    (select invoice.cus_code from invoice natural join line
    where p_code='23109-HB') CP2
where customer.cus_code=cp1.cus_code and cp1.cus_code=cp2.cus_code;

-- Attribute LIST SUBQUERIES
select p_code, p_price, (select avg(p_price) from product) as avgprice,
	p_price-(select avg(p_price) from product) as diff
from product;

-- correlated subquery  (Does outer first, then inner. This passes the first P_CODE from outer, and then calcs the average for that product)
select inv_number, line_number, p_code, line_units
from line ls
where ls.line_units > (select avg(line_units)
						from line la
						where la.p_code=ls.p_code);

-- exists query (correlated)   exists is only for subquerys

select cus_code, cus_lname, cus_fname
from customer
where exists (select cus_code from invoice
				where invoice.cus_code=
                customer.cus_code);

-- This doesn't work
select invoice. inv_number, customer.cus_code, cus_lname, cus_fname
from customer, invoice
where invoice.cus_code=
customer.cus_code
order by inv_number;

-- Date time queries
SELECT DAYOFMONTH('2001-11-10'), MONTH('2005-03-05');
SELECT ADDDATE('2008-01-02', 31);
select emp_lname, emp_fname, emp_dob, year(emp_dob) as YEARBORN
from emp where year(emp_dob)> 1959;

-- Case SQL Statements
select lower(emp_lname) from emp;
select upper(emp_lname) from emp;
select emp_lname from emp where lower(emp_lname) like 'smi%';

-- Create another Table Similar to another table
drop table  if exists customer_2;
CREATE TABLE CUSTOMER_2 (
CUS_CODE int,
CUS_LNAME varchar(15),
CUS_FNAME varchar(15),
CUS_INITIAL varchar(1),
CUS_AREACODE varchar(3),
CUS_PHONE varchar(8)

);

-- Populate a Table similar to another table
INSERT INTO CUSTOMER_2 VALUES(345,'Terrell','Justine','H','615','322-9870');
INSERT INTO CUSTOMER_2 VALUES(347,'Olowski','Paul','F',615,'894-2180');
INSERT INTO CUSTOMER_2 VALUES(351,'Hernandez','Carlos','J','723','123-7654');
INSERT INTO CUSTOMER_2 VALUES(352,'McDowell','George',NULL,'723','123-7768');
INSERT INTO CUSTOMER_2 VALUES(365,'Tirpin','Khaleed','G','723','123-9876');
INSERT INTO CUSTOMER_2 VALUES(368,'Lewis','Marie','J','734','332-1789');
INSERT INTO CUSTOMER_2 VALUES(369,'Dunne','Leona','K','713','894-1238');


-- Create a Union
select cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone
from customer
union
select cus_lname, cus_fname, cus_initial, cus_areacode, cus_phone from customer_2;

-- Intersect Query (MYSQL DOES NOT SUPPORT)

select cus_code from customer 
where cus_areacode='615' and 
cus_code in (SELECT DISTINCT  cus_code from invoice);

-- minus alternative
select cus_code from customer 
where cus_areacode='615' and 
cus_code not in (SELECT DISTINCT  cus_code from invoice);

-- create view
drop view if exists prod_stats;

create view prod_stats as
select v_code, sum(P_QOH*p_price) as totcost, max(P_QOH) as Maxqty,
	MIN(P_QOH) AS MINQTY, AVG(p_qoh) AS AVGQTY
    FROM PRODUCT
    GROUP BY V_CODE;
    
select * from prod_stats;


drop trigger if exists before_employe_update;
drop table if exists employees_audit;

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON emp
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.emp_num,
     lastname = OLD.emp_lname,
     changedat = NOW();     

show triggers;
UPDATE emp
SET 
    emp_lname = 'Phan'
WHERE
    emp_num = 100;
    
 select * from employees_audit;
 
drop trigger before_employee_update;
drop table employees_audit;








