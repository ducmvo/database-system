**HW3 – DUC VO**

6.5. To keep track of office furniture, computers, printers, and other office equipment, the FOUNDIT Company uses the table structure shown in Table P6.5. 

1. Given that information, write the relational schema and draw the dependency diagram. Make sure that you label the transitive and/or partial dependencies. 

![Diagram Description automatically generated](static/bae98f04-d689-48ab-b551-3e0be0c8d1fd.001.png)Relational schema:
ITEM(ITEM\_ID, ITEM\_LABEL, ROOM\_NUMBER, BLDG\_CODE, BLDG\_NAME, BLDG\_MANAGER)

1. Write the relational schema and create a set of dependency diagrams that meet 3NF requirements. Rename attributes to meet the naming conventions and create new entities and attributes as necessary. 

![Diagram Description automatically generated](static/bae98f04-d689-48ab-b551-3e0be0c8d1fd.002.png)![Diagram Description automatically generated](static/bae98f04-d689-48ab-b551-3e0be0c8d1fd.003.png)![Diagram Description automatically generated](static/bae98f04-d689-48ab-b551-3e0be0c8d1fd.004.png)Relational schemas:
**ITEM**(ITEM\_ID, ITEM\_LABEL, ROOM\_NUMBER, BLDG\_CODE)
**EMPLOYEE**(EMP\_CODE, EMP\_FNAME, EMP\_LNAME)
**BUILDING**(BLDG\_CODE, BLDG\_NAME, EMP\_CODE)

1. ![Diagram Description automatically generated](static/bae98f04-d689-48ab-b551-3e0be0c8d1fd.005.png)Draw the Crow’s Foot ERD. 
