# Pewlett-Hackard-Analysis
# Over View Of Analysis

### Database keys
  **Database Keys** identify records from tables and establish relationships between tables. There are many types of keys. We used 2 type of keys here,**PRIMARY KEYS and FOREIGN KEYS**
    
### Primary keys
   **Primary Keys** are most essential keys for database and tables.It is an Unique Identity of each table and Database.When table are created primary keys are must to add, primary keys created the link between the table or as I said estblished a relationship between two tables.
### Foreign Keys
   **Foreign keys** are the primary keys of another tables which saved as Forign keys in the other tables.so, basically as Primary keys are unique identification for the table like that foreign keys are unique identifications of the other tables. It is as important as Primary keys.
### Entity Relationship Diagram(ERD)
   **Entity Relationship Diagram (ERD)** is the most important part of SQL. It is the flowchart of the Database which contain Primary keys,Foreign Keys and Datatypes of the columns.ERD also shows the flow of the tables.
   ![Image]()
   
# Deliverable 1: The Number of Retiring Employees by Title
   In this task we have to display the Number of Retiring Employees by title with the used of joing tables query.
   First We have to retrive **emp_no,first_name and last_name** from the table **Employees** and **title,from_date and to_date** from the **Titles** table, after retrivig that columns from the tables we create the another table to save the output called **retirement_titles** table. To getting retirement_titles table data we have to join or merge the Employees table and Titles table and then we have to performing filterretion on the birth_date column for getting the data.
   ![Image]()
   ![Image]()
   After getting the desired data we saved that data as the csv file.
   ![Image]()
   After getting this .CSV file we have to drop duplicates from that table and csv for that we used **Distinct On()** 
   ![image]()
   After performing that we have to retrieve the number of employees by their most recent job title who are about to retire and put that numbers into **Descending** order.
   ![Image]()
   
# Deliverable 2: The Employees Eligible for the Mentorship Program
# Deliverable 3: A written report on the employee database analysis


