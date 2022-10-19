# Pitchbook-Project

Welcome to my Pitchbook Project

Summary:
There are three CSVs containing records for Opportunities,
Accounts, and Sales Representatives. Below is a description of the data and how the
tables relate to one another. Each record in these table represents a closed sales cycle or ‘Opportunity’ in our Sales
system. My Goal is to clean, analyze and visualize the three csv files in order to answer the business questions below.

1. What is the mean and median number of days to close (the  difference in days between “CREATED_DATE” and  
“CLOSE_DATE”)? 
  a. In what situations do you think each measure is more  relevant? 
  b. Do they meaningfully differ overall? 
  c. Do they differ by Outcome? 
  d. Do they differ by Office? 
  e. Do they differ by Primary Type? 
2. What is the mean and median duration of Opportunities in the  Evaluation stage? 
  a. Does this differ by Primary Type? 
  b. Does the duration of an Opportunity in the Evaluation stage  correlate with a given Outcome? 
3. From your answers to the questions above, what additional insights  do you have about our business?



Assumptions:
- If there was no Evaluation date I excluded it from the data since technically it had never started the evaluation stage. 
- If there was no date in the next stage (procurement/negotiation) or (Verbal/pending) I used the Closed date as the date to subtract


Tools Used:
Excel: for data cleaning/manipulation
MySQL: for data cleaning/analyzing
Tableau: for Visualization/analyzing

* all figures can be seen in the tableau file


1. What is the mean and median number of days to close (the  difference in days between “CREATED_DATE” and  
“CLOSE_DATE”)? 
- the mean = 99.41 and the median = 48 with a delta of 51.41.
See figure 1a.


a. In what situations do you think each measure is more  relevant?
- The mean is better used when there are little to no outliers that can skew the data.
- The median is better used when there are outliers in the data which may be the case here.


 b. Do they meaningfully differ overall?
- In this case they do differ meaningfully overall. With the mean double the median. This tells me that there are a few data points in which the days to close were extremely long. 

 c. Do they differ by Outcome?
- The mean and median do differ by outcome. Sales that were won had a mean = 114 and median = 37 with a delta of 77
while sales that were lost had a mean = 98.19 and a median = 48 with a delta of 50.19. This could be because sales that were won  had to have more work
and were harder to earn. See figure 1b.

 d. Do they differ by Office?
- There was a significant difference in the mean and median in most offices except for San Fransisco and Hong Kong which lined up exaclty or almost exactly.
See figure 1c.

 e. Do they differ by Primary Type?
- The trend of differing means vs median continued when looking at primary type. All of the values had significant deltas.
See figure 1d.



2. What is the mean and median duration of Opportunities in the Evaluation stage?
- For the evaluation duration the mean = 100.7 and the median = 65 with a delta of 35.7 see figure 2a.

 a. Does this differ by Primary Type?
- There are significant delta's in the mean and median when looking at the evaluation duration by primary type. See figure 2b. 

 b. Does the duration of an Opportunity in the Evaluation stage  correlate with a given Outcome?
- There does seem to be a correlation in the Evaluation stage. sales that were won had a much lower mean and median duration then those that were lost.
See figure 2c.


3. From your answers to the questions above, what additional insights  do you have about our business?
-  Some additional insights that I found were that the conversion rate for opportunities was about 7%
-  I found that there were multiple opportunites that spanned a thousand plus days. This could be the reason many of the means were so high compared to 
 the median.
- The office with the highest days to close was Hong Kong and the lowest was the marketing office. Both of these had means and medians close to one another. As you get towards the middle however the means and medians start to increase in delta size.









