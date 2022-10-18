USE Pitchbook_project;

-- Cleaning Data
SHOW COLUMNS FROM opportunity_table;
SHOW COLUMNS FROM account_table;
SHOW COLUMNS FROM salesrep_table;

-- Changing from Text to VARCHAR and DATE for Opportunity table
ALTER TABLE `Pitchbook_project`.`opportunity_table` 
CHANGE COLUMN `OPP_ID` `OPP_ID` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `ACCOUNT_ID` `ACCOUNT_ID` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `OWNER_REP_ID` `OWNER_REP_ID` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `OUTCOME` `OUTCOME` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `CREATED_DATE` `CREATED_DATE` DATE NULL DEFAULT NULL ,
CHANGE COLUMN `CLOSE_DATE` `CLOSE_DATE` DATE NULL DEFAULT NULL ;

SELECT * 
FROM Opportunity_table


-- Changing from Text to VARCHAR for Account table
ALTER TABLE `Pitchbook_project`.`account_table` 
CHANGE COLUMN `ACCOUNT_ID` `ACCOUNT_ID` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `PRIMARY_TYPE` `PRIMARY_TYPE` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `SECONDARY_TYPE` `SECONDARY_TYPE` VARCHAR(50) NULL DEFAULT NULL ;

SELECT * 
FROM account_table


-- Changing from Text to VARCHAR for Salesrep table
ALTER TABLE `Pitchbook_project`.`salesrep_table` 
CHANGE COLUMN `REP_ID` `REP_ID` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `OFFICE` `OFFICE` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `NAME` `NAME` VARCHAR(30) NULL DEFAULT NULL ,
CHANGE COLUMN `EMAIL` `EMAIL` VARCHAR(50) NULL DEFAULT NULL ;

SELECT * 
FROM salesrep_table

--------------------------------------------------------------------------------------------------------------------------------
# 1.What is the mean and median number of days to close? 

-- creating a new column for the number of days to close
SELECT *,
  DATEDIFF(CLOSE_DATE, CREATED_DATE) AS DAYS_TO_CLOSE
FROM opportunity_table; 

ALTER TABLE `Pitchbook_project`.`opportunity_table` 
ADD DAYS_TO_CLOSE INT; /* added to the table for easier use later on */

UPDATE Pitchbook_project.opportunity_table
SET DAYS_TO_CLOSE = DATEDIFF(CLOSE_DATE, CREATED_DATE);



--------------------------------------------------------------------------------------------------------------------------------
-- Finding the Mean; Total mean = 99.4095
SELECT  AVG(DAYS_TO_CLOSE) as Days
FROM opportunity_table
ORDER BY Days;

-- Outcome Mean | Lost = 98.19 | Closed Won = 114.88
SELECT  OUTCOME, AVG(DAYS_TO_CLOSE) as Days
FROM opportunity_table
GROUP BY OUTCOME
ORDER BY Days;


-- Mean office
SELECT Join_table.office, AVG(join_table.DAYS_TO_CLOSE) AS Days
FROM (
SELECT Opportunity_table. *, salesrep_table.Office, salesrep_table.REP_ID
FROM opportunity_table /* Inner Query joins the Opportunity table to sales rep table*/
INNER JOIN salesrep_table ON opportunity_table.Owner_rep_ID=salesrep_table.REP_ID
	) AS join_table
GROUP BY join_table.Office
ORDER BY Days;/* outer query then uses the join table to get the mean of days to close and group it by office */


-- Mean Primary type
SELECT Join_table.Primary_type, AVG(join_table.DAYS_TO_CLOSE) AS Days
FROM (
SELECT Opportunity_table. *, account_table.Primary_type, Account_table.secondary_type
FROM opportunity_table 
INNER JOIN account_table ON opportunity_table.account_ID=account_table.account_ID
	) AS join_table
GROUP BY join_table.primary_type
ORDER BY Days;

--------------------------------------------------------------------------------------------------------------------------------
-- Finding the Median| Total Median = 48
 SELECT AVG(dd.DAYS_TO_CLOSE) as median_val
FROM (
SELECT d.DAYS_TO_CLOSE, @rownum:=@rownum+1 as `row_number`, @total_rows:=@rownum
  FROM opportunity_table d, (SELECT @rownum:=0) r
  WHERE d.DAYS_TO_CLOSE is NOT NULL 
  ORDER BY d.DAYS_TO_CLOSE 
) as dd
WHERE dd.row_number IN ( FLOOR((@total_rows+1)/2), FLOOR((@total_rows+2)/2) ); 

# How it works
-- The inner query assigns @rownum as incremental index and sorts the selected values.
-- The outer query uses @total_rows to determine the median, irrespective of whether there are odd or even number of values.


-- median by outcome LOST = 48| CLOSED WON = 37
 SELECT AVG(dd.DAYS_TO_CLOSE) as median_val
FROM (
SELECT d.DAYS_TO_CLOSE, @rownum:=@rownum+1 as `row_number`, @total_rows:=@rownum
  FROM opportunity_table d, (SELECT @rownum:=0) r
  WHERE d.DAYS_TO_CLOSE is NOT NULL
  AND d.OUTCOME='LOST'
  ORDER BY d.DAYS_TO_CLOSE
) as dd
WHERE dd.row_number IN ( FLOOR((@total_rows+1)/2), FLOOR((@total_rows+2)/2) );
  
  
  SELECT AVG(dd.DAYS_TO_CLOSE) as median_val
FROM (
SELECT d.DAYS_TO_CLOSE, @rownum:=@rownum+1 as `row_number`, @total_rows:=@rownum
  FROM opportunity_table d, (SELECT @rownum:=0) r
  WHERE d.DAYS_TO_CLOSE is NOT NULL
  AND d.OUTCOME='CLOSED WON'
  ORDER BY d.DAYS_TO_CLOSE
) as dd
WHERE dd.row_number IN ( FLOOR((@total_rows+1)/2), FLOOR((@total_rows+2)/2) );

-- median by office & Primary type were done  in Tableau for easier use.

--------------------------------------------------------------------------------------------------------------------------------

-- finding the Evaluation Duration done in Tableau

-- Assumptions
-- 1. If there was no Evaluation date I excluded it from the data since technically it had never started the evaluation stage.
-- 2. If there was no date in the next stage (procurment/negotiation) or (Verbal/pending)I used the Closed date as the date to subtract from as it's still technically in the evaluation stage until it's either moved to the next stage or the opportunity is closed.

