**HW5 - Transactions & Database Programming**

**Essay Questions**

A.	What are some valid reasons why somebody would want to relax their Isolation Level, for example using READ COMMITTED instead of READ REPEATABLE?

Read Committed forces transactions to read only committed data. At this level, the database will use exclusive locks on data, causing other transactions to wait until the original transaction commits. 

The Repeatable Read isolation level uses shared locks to ensure other transactions do not update a row after the original query reads it. However, new rows are read (phantom read) as these rows did not exist when the first query ran.

The higher the isolation level (more restrictive) the more locks (shared and exclusive) are required to improve data consistency, at the expense of transaction concurrency performance.

Valid reason to consider relaxing these isolation levels are to boost performance for systems that have majority of operations that reading from database or systems that have microservices architecture design.

B.	What does "A" in ACID mean? Give me an example.

“A” in ACID means Atomicity.
Atomicity requires that all operations of a transaction be completed; if not, the transaction is aborted. A transaction is treated as a single, indivisible, logical unit of work.

Example If a transaction T1 has four SQL requests, all four requests must be successfully completed; otherwise, the entire transaction is aborted. 

C.	What is the value of a Transaction Log?

The transaction log is a critical part of the database. Transaction logs can ensure the DBMS’s ability to recover transactions. It contains data for database recovery purposes. Database transaction recovery uses data in the transaction log to recover a database from an inconsistent state to a consistent state. Database recovery is triggered when a critical event occurs, such as Hardware/software failures, Human-caused incidents, Natural disasters.

D.	Your team at work is debating about replacing their low-level SQL interface with an ORM. Argue for or against this, explaining the benefits and risks of using an ORM.

There are many benefits using an ORM

- Provides highly efficient ways to organize and maintain your codes using OOP and inheritance which are very beneficial to scale a large project.
- Prevent errors that can potentially causes major damage to the database system by sanitizing and preventing dangerous SQL injection and unintential queries.
- Providing easy-to-use objects and interfaces that have well-constructed methods and SQL statements behind the scenes.
- Many complex but common tasks are already built.
- Provide high abstraction and help focusing on the business logic side rather than spend time poorly writing performance SQL which can be costly.
- Have many libraries that provide more sophisticated, streamlined functionality.
- Have code generation or manual definition of classes that correspond to entities/tables. 




E.	In what ways is REST different from SQL?

`	`REST uses the URL of a request to identify a specific resource. REST API basically use hard-code SQL to do CRUD operations using specific patterns from the URL. Using the REST API can help with organization and save time but might have limitation and less flexibility on complex SQL queries.

**Programming**  
java

**Extra Credit![Graphical user interface, application, table, Excel Description automatically generated](static/3df5fd70-2d8b-4734-8c65-50ce571f35bb.001.png)**
