use clean;


-- 1. Write an SQL query to identify the age group which is taking more loan 
-- and then calculate the sum of all of the balances of it?

   select age, count(age)as no_of_clients, sum(balance) as  whole_balance from bank_df 
   where h_loan = 'yes' or p_loan = 'yes' group by age order by no_of_clients desc;  -- filtered by housing and personal loans
   
 # Observe the output, Top-10 ages have more clients who are taking loans 
 # we can consider 30-40 age group clients are taking more loans  
 
-- 2. Write an SQL query to calculate for each record if a loan has been taken less than 100 persons,
-- then calculate the fine of 15% of the current balance and create a temp table
-- and then add the amount for each month from that temp table? 
    
   # Case -1 If we consider the question as "loan has been taken less than 100 persons" then no records will available because h_loan & p_loan having large number of clients
   # Case -2 Considering the loan for all records 
   
   select age,balance * 0.15 as fine from bank_df where h_loan = 'yes' or p_loan = 'yes' limit 9999999;
   
   #Creating temporary table 
   create temporary table temp (month varchar(10),balance int);
   
   #inserting values under given condition
   insert into temp(month,balance)
   select month,sum(balance) 
   from bank_df group by month;
   
   #Output
   select * from temp;
   
   
-- 3. Write an SQL query to calculate each age group along with each department's highest balance record? 

   select age,job,max(balance) from bank_df group by age order by age; -- considering department as job
   
   #You can see the highest balance in each age with each job

-- 4. Write an SQL query to find the secondary highest education, where duration is more than 150.
-- The query should contain only married people, and then calculate the interest amount? (Formula interest => balance*15%). 
   
   select balance*0.15 as interest,age from bank_df where duration>2.5 and education = 'secondary' and 
   marital  = 'married' limit 99999999;   #since I have duration in minutes so 150 sec = 2.5 min
   
   -- Getting the required result using where for multiple conditions
   
-- 5. Write an SQL query to find which profession has taken more loan along with age?

   select job,age,(count(h_loan) + count(p_loan)) loan_count from bank_df where h_loan = 'yes' or p_loan = 'yes' group by job order by loan_count desc;

   -- "Blue-collar" profession has taken more loans 
-- 6. Write an SQL query to calculate each month's total balance and then 
-- calculate in which month the highest amount of transaction was performed?

   select month,sum(balance) balance from bank_df group by month order by balance desc;
   
-- The highest balance was perfomed in the month of "May"

