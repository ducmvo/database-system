Duc Vo

Nov 9 20201

**Chapter 8**

**Review Questions**

1. What type of integrity is enforced when a primary key is declared? 

Entity Integrity (i.e. PK must be unique and not NULL).

4. What are “referential constraint actions”? 

A referential constraint action is an insertion, update, or deletion action in the referenced table it is specified with CASCADE or RESTRICT to ensure the preservation of referential integrity.

4. What is the purpose of a CHECK constraint? 

The CHECK constraint is used to validate data when an attribute value is entered. It checks to see that a specified condition exists. If the CHECK constraint is met for the specified attribute (i.e., the condition is true), the data is accepted for that attribute. If the condition is found to be false, an error message is generated, and the data is not accepted.

4. Explain when an ALTER TABLE command might be needed. 

All changes in the table structure are made by using the ALTER TABLE command followed by a keyword that produces the specific change you want to make. Three options are available: ADD, MODIFY, and DROP. For example, the ALTER TABLE command might be needed when: Changing a Column’s Datatype, Data Characteristics, Adding/Dropping a Column, Adding Primary Key, Foreign Key, and Check Constraints.

4. What is the difference between an INSERT command and an UPDATE command? 

SQL requires the use of the insert command to enter data into a table while UPDATE command is used to modify data in a table. INSERT creates new rows in the table, while UPDATE changes rows that already exist.

9. What is the difference between a view and a materialized view? 

Views can be created to expose subsets of data to end users primarily for security and privacy reasons. Normally, views only store the SELECT statement to produce the view. Materialized views store a separate copy of the data and must be refreshed regularly. A materialized view is a dynamic table that not only contains the SQL query command to generate the rows, it stores the actual rows. The materialized view rows are automatically updated when the base tables are updated



**Problems**

1. Write the SQL code that will create only the table structure for a table named EMP\_1. This table will be a subset of the EMPLOYEE table. The basic EMP\_1 table structure is summarized in the following table. Use EMP\_NUM as the primary key. Note that the JOB\_CODE is the FK to JOB so be certain to enforce referential integrity. Your code should also prevent null entries in EMP\_LNAME and EMP\_FNAME.

CREATE TABLE EMP\_1 (

`  `EMP\_NUM CHAR(3) NOT NULL,

`  `EMP\_LNAME VARCHAR(15) NOT NULL,

`  `EMP\_FNAME VARCHAR(15) NOT NULL,

`  `EMP\_INITIAL CHAR(1) NULL DEFAULT NULL,

`  `EMP\_HIREDATE DATE NULL DEFAULT NULL,

`  `JOB\_CODE CHAR(3) NULL DEFAULT NULL,

`  `PRIMARY KEY (EMP\_NUM),

`  `FOREIGN KEY (JOB\_CODE) REFERENCES JOB(JOB\_CODE) ON UPDATE CASCADE

);

4. Write the SQL code that will save the changes made to the EMP\_1 table (if supported by your DBMS).

COMMIT; 

7. Write the SQL code to create a copy of EMP\_1, including all its data, and naming the copy EMP\_2. 

CREATE TABLE EMP\_2 AS

SELECT \* FROM EMP\_1;

9. Using the EMP\_2 table, write a single SQL command to change the EMP\_PCT value to 5.00 for the people with employee numbers 101, 105, and 107. 

UPDATE EMP\_2

SET EMP\_PCT = 5.00

WHERE EMP\_NUM IN (101, 105, 107);
