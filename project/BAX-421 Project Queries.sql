############################################################################################################
-- BAX-421 Project Phase 4: SQL + Data visualizations
-- Yi Yin (Ian) Chen
############################################################################################################
-- Business Questions
############################################################################################################
-- Question 1
-- What is the distribution of term deposit subscriptions across different job categories 
-- and how does age factor into this?
## Subscription distribution across job categories
SELECT 
    j.job_title AS Job_Category, 
    COUNT(*) AS Subscription_Count
FROM 
    Person p
JOIN 
    Job j ON p.job_id = j.job_id
WHERE 
    p.subscribed = 'yes'
GROUP BY 
    j.job_title
ORDER BY 
    j.job_title;
## Factoring in age
SELECT 
    j.job_title AS Job_Category, 
    p.age AS Age, 
    COUNT(*) AS Subscription_Count
FROM 
    Person p
JOIN 
    Job j ON p.job_id = j.job_id
WHERE 
    p.subscribed = 'yes'
GROUP BY 
    j.job_title, 
    p.age
ORDER BY 
    j.job_title, 
    p.age;
## Create bins for age
SELECT 
    job_title,
    CASE 
        WHEN age < 30 THEN '<30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_bin,
    COUNT(*) AS subscription_count
FROM 
    Person
JOIN 
    Job ON Person.job_id = Job.job_id
WHERE 
    subscribed = 'yes'
GROUP BY 
    job_title,
    age_bin
ORDER BY 
    job_title,
    age_bin;
-- Subscription Distribution by Job Category:

-- The 'admin.' job category has the highest subscription count, significantly more than the others, suggesting that individuals in administrative roles may be more responsive to the campaign or more numerous in the dataset.
-- 'Blue-collar' and 'technician' job categories also show higher subscription counts compared to other roles, indicating these groups are good targets for marketing efforts.
-- Categories like 'unknown', 'unemployed', and 'entrepreneur' have the lowest subscription counts, which could imply that they are less likely to subscribe or are less represented in the dataset.
-- Age Distribution across Job Categories:

-- There is a noticeable peak in subscriptions among younger individuals in the 'admin.' category, especially those under 40. This suggests targeting younger administrative professionals could be beneficial.
-- For 'blue-collar' workers, the distribution is more evenly spread across age groups, but still with a focus on those under 40.
-- In contrast, the 'retired' category shows a high subscription rate for individuals over 50, which is expected given the nature of the job category.
-- Heatmap Analysis (Job vs. Age Bins):

-- The heatmap highlights that younger age bins (<30, 30-39) have higher subscription rates across multiple job categories, indicating that younger individuals are more inclined to subscribe.
-- For certain job categories like 'management', 'services', 'technician', and 'admin.', the 30-39 age bin is particularly active, which could be an indicator of these individuals being at a stage in their career where the offered subscription is appealing.
-- The 'retired' group shows a different pattern, with the 50+ age bin being the most subscribed, aligning with the retirement age and possibly more financial freedom or interest in the services offered.
############################################################################################################
-- Question 2
-- How does the level of education influence a client's decision to subscribe to a term deposit?
SELECT 
    e.education_level AS ED_LEVEL, 
    COUNT(*) AS TOTAL_CLIENTS,
    SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS SUBSCIRBED,
    SUM(CASE WHEN p.subscribed = 'no' THEN 1 ELSE 0 END) AS NOT_SUBSRIBED,
    ROUND((SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS SUB_RATE
FROM 
    Person p
JOIN 
    Education e ON p.education_id = e.education_id
GROUP BY 
    ED_LEVEL
ORDER BY 
    SUB_RATE DESC;
-- Education Level and Subscription Rate: 
-- There is a clear trend that as the education level increases, the subscription rate also tends to be higher, with 'illiterate' clients having the highest subscription rate. This could suggest that individuals with no formal education are more receptive to subscribing, possibly due to the offering being more appealing or necessary for their financial management.

-- Targeting University Degree Holders: 
-- While 'university.degree' holders have a subscription rate that is not the highest, they have the highest number of clients who subscribed. This suggests that while their individual conversion rate is lower, the sheer number of potential clients makes them a significant target group for marketing campaigns.

-- Basic Education and Lower Subscription Rates: 
-- Clients with only basic education levels (4y, 6y, 9y) tend to have the lowest subscription rates. This might indicate a need for tailored marketing strategies that address the specific needs or preferences of this demographic.

-- Effectiveness of Campaigns Across Education Levels: 
-- The significant variance in subscription rates across different education levels suggests that the effectiveness of marketing campaigns might vary significantly based on the clients' educational background.

############################################################################################################
-- Question 3
-- What patterns emerge in term deposit subscriptions with respect to different months and contact methods? 
SELECT 
    c.month, 
    c.contact_type,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS subscribed_count,
    SUM(CASE WHEN p.subscribed = 'no' THEN 1 ELSE 0 END) AS not_subscribed_count,
    ROUND((SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS subscription_rate
FROM 
    Person p
JOIN 
    Contact c ON p.contact_id = c.contact_id
GROUP BY 
    c.month, c.contact_type
ORDER BY 
    FIELD(c.month, 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'), 
    c.contact_type;
## Day of week analysis
SELECT 
    c.day_of_week, 
    c.contact_type,
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS subscribed_count,
    SUM(CASE WHEN p.subscribed = 'no' THEN 1 ELSE 0 END) AS not_subscribed_count,
    ROUND((SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS subscription_rate
FROM 
    Person p
JOIN 
    Contact c ON p.contact_id = c.contact_id
GROUP BY 
    c.day_of_week, c.contact_type
ORDER BY 
    FIELD(c.day_of_week, 'mon', 'tue', 'wed', 'thu', 'fri');
-- High Subscription Rate for Cellular Contacts in March and December: There is a significant spike in subscription rates for cellular contacts in March and December, suggesting these might be effective months for cellular campaigns.

-- Low Subscription Rates for Telephone Contacts in May: Telephone contacts have an exceptionally low subscription rate in May, which could indicate a seasonal trend or campaign ineffectiveness during this period.

-- Significant Difference Between Contact Types: The cellular contact type consistently shows a higher subscription rate than the telephone contact type, which could suggest that cellular contacts are more engaged or receptive.

-- Effective Months for Cellular Campaigns: For cellular contacts, March, June, September, October, and December show remarkably higher subscription rates, indicating these months could be the best times to intensify marketing efforts.

-- Telephone Contacts in September and October: There's a noticeable increase in the subscription rate for telephone contacts during September and October, suggesting a potential seasonal opportunity for telephone-based campaigns.

-- Midweek Engagement: Midweek days (Tuesday and Wednesday) show strong performance for cellular contacts, suggesting that clients might be more receptive to communication during this period.

############################################################################################################
-- Question 4
-- Does the outcome of previous marketing campaigns correlate with the current campaign's success rate?
SELECT 
    c.poutcome,
    COUNT(*) AS total_current_campaign_contacts,
    SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS current_campaign_subscribed_count,
    ROUND((SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS current_campaign_subscription_rate
FROM 
    Person p
JOIN 
    Campaign c ON p.campaign_id = c.campaign_id
WHERE 
    c.poutcome IS NOT NULL
GROUP BY 
    c.poutcome
ORDER BY 
    current_campaign_subscription_rate DESC;
-- Strong Influence of Previous Success: There's a clear correlation where previous successful outcomes have a significantly higher subscription rate in the current campaign (65.11%) compared to failures and nonexistents. This indicates that previous success is a strong predictor of future performance.

-- Low Conversion on No Previous Contact: Clients with no previous contact (nonexistent) have the lowest subscription rate (8.83%), which might suggest the need for more effective initial engagement strategies.

-- Moderate Impact of Previous Failures: While previous failures have a lower subscription rate (14.23%) compared to successes, they still convert better than nonexistent contacts. This could imply that any previous engagement, even unsuccessful, is better than none.
############################################################################################################
-- Question 5
-- How do key economic indicators like the employment rate and consumer confidence index affect the propensity for subscribing to term deposits?
SELECT
    E.emp_var_rate,
    E.cons_price_idx,
    E.cons_conf_idx,
    E.euribor3m,
    E.nr_employed,
    COUNT(P.person_id) AS total_clients,
    SUM(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END) AS subscribed_count,
    (SUM(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(P.person_id)) * 100 AS subscription_rate
FROM
    Person AS P
JOIN
    Economic AS E ON P.economic_id = E.economic_id
GROUP BY
    E.emp_var_rate,
    E.cons_price_idx,
    E.cons_conf_idx,
    E.euribor3m,
    E.nr_employed;
#Correlations
SELECT 
    (AVG(E.emp_var_rate * (CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) - AVG(E.emp_var_rate) * AVG(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) / 
    (STDDEV(E.emp_var_rate) * STDDEV(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) AS correlation_coefficient
FROM 
    Person AS P
JOIN 
    Economic AS E ON P.economic_id = E.economic_id;
-- -0.3
############################################################################################################
SELECT 
    (AVG(E.cons_price_idx * (CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) - AVG(E.cons_price_idx) * AVG(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) / 
    (STDDEV(E.cons_price_idx) * STDDEV(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) AS correlation_coefficient
FROM 
    Person AS P
JOIN 
    Economic AS E ON P.economic_id = E.economic_id;
-- -0.14
############################################################################################################
SELECT 
    (AVG(E.cons_conf_idx * (CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) - AVG(E.cons_conf_idx) * AVG(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) / 
    (STDDEV(E.cons_conf_idx) * STDDEV(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) AS correlation_coefficient
FROM 
    Person AS P
JOIN 
    Economic AS E ON P.economic_id = E.economic_id;
-- 0.05
############################################################################################################
SELECT 
    (AVG(E.euribor3m * (CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) - AVG(E.euribor3m) * AVG(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) / 
    (STDDEV(E.euribor3m) * STDDEV(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) AS correlation_coefficient
FROM 
    Person AS P
JOIN 
    Economic AS E ON P.economic_id = E.economic_id;
-- -0.31
############################################################################################################
SELECT 
    (AVG(E.nr_employed * (CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) - AVG(E.nr_employed) * AVG(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) / 
    (STDDEV(E.nr_employed) * STDDEV(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END)) AS correlation_coefficient
FROM 
    Person AS P
JOIN 
    Economic AS E ON P.economic_id = E.economic_id;
-- -0.35
-- Employment Variation Rate (-0.3): Higher employment variation correlates with lower subscription rates, suggesting instability in employment may discourage term deposit commitments.

-- Consumer Price Index (-0.14): A slight negative correlation implies that higher inflation (or cost of living) marginally reduces the likelihood of subscribing to term deposits.

-- Consumer Confidence Index (0.05): Shows a negligible correlation, indicating that consumer confidence has little to no impact on term deposit subscriptions.

-- Euribor 3-month Rate (-0.31): A moderate negative correlation suggests that higher Euribor rates, indicating higher interest rates, correspond with lower term deposit subscriptions.

-- Number of Employed (-0.35): The strongest negative correlation, indicating that higher employment rates are associated with lower interest in term deposits, possibly due to more diverse investment options.
############################################################################################################
-- Question 6
-- Is there a notable difference in subscription rates among different marital statuses?
SELECT 
    P.marital_status,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END) AS subscribed_count,
    (SUM(CASE WHEN P.subscribed = 'yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS subscription_rate
FROM 
    Person AS P
GROUP BY 
    P.marital_status
ORDER BY 
    subscription_rate DESC;
-- Unknown Marital Status (15% Subscription Rate):

-- With the highest subscription rate among all groups, this category, though it has the smallest sample size (only 80 clients), shows a relatively high interest in term deposits.
-- The high rate could be influenced by various factors, including individual financial goals or circumstances not captured by the marital status.
-- Single (14.0041% Subscription Rate):

-- Singles represent a significant portion of the clientele and show a notably higher subscription rate compared to divorced and married categories.
-- This could suggest that single individuals might have different financial priorities or more flexibility to invest in term deposits.
-- Divorced (10.3209% Subscription Rate):

-- The divorced group has a moderately low subscription rate.
-- This could be due to various financial commitments or priorities that differ from those who are single or married.
-- Married (10.1573% Subscription Rate):

-- Despite being the largest group, married individuals have the lowest subscription rate among the categories.
-- This could indicate different financial responsibilities or preferences for other types of investments or savings plans among married clients.
############################################################################################################
-- Question 7
-- What is the typical duration of successful marketing calls compared to those that do not result in a subscription?
SELECT 
    P.subscribed,
    AVG(C.duration) AS average_call_duration,
	STDDEV(C.duration) AS stddev_duration,
    MAX(C.duration) AS max_duration_in_group,
    MIN(C.duration) AS min_duration_in_group
FROM 
    Contact AS C
JOIN 
    Person AS P ON C.contact_id = P.contact_id
GROUP BY 
    P.subscribed;

SELECT 
    P.contact_id,
    C.duration,
    P.subscribed,
	AVG(C.duration) OVER (PARTITION BY P.subscribed) AS mean_duration,
    STDDEV(C.duration) OVER (PARTITION BY P.subscribed) AS stddev_duration,
    MAX(C.duration) OVER (PARTITION BY P.subscribed) AS max_duration_in_group,
    MIN(C.duration)  OVER (PARTITION BY P.subscribed) AS min_duration_in_group,
    PERCENT_RANK() OVER (PARTITION BY P.subscribed ORDER BY C.duration) AS percentile_rank,
	CASE 
        WHEN C.duration <= 60 THEN '0-60 seconds'
        WHEN C.duration > 60 AND C.duration <= 120 THEN '61-120 seconds'
        WHEN C.duration > 120 AND C.duration <= 180 THEN '121-180 seconds'
        WHEN C.duration > 180 AND C.duration <= 240 THEN '181-240 seconds'
        WHEN C.duration > 240 AND C.duration <= 300 THEN '241-300 seconds'
        ELSE 'Over 300 seconds'
    END AS duration_bin
FROM 
    Contact AS C
JOIN 
    Person AS P ON C.contact_id = P.contact_id;
-- Insights from the 'No Subscription' Group (Subscribed = 'no'):
-- Longest Duration Call: The maximum call duration in this group is 4918 seconds, which is notably long. However, this is an outlier compared to the mean duration.

-- Average Duration: The mean (average) call duration is approximately 221 seconds, which indicates that most calls are significantly shorter than the longest call.

-- Standard Deviation: The standard deviation is about 207 seconds, suggesting a wide variation in call durations within this group.

-- Percentile Rank Close to 1: The percentile ranks for longer calls are very close to 1, indicating that these calls are among the longest in the 'no subscription' group.

-- Insights from the 'Subscription' Group (Subscribed = 'yes'):
-- Shortest Duration Call: The minimum call duration is 37 seconds, which is considerably short, especially when compared to the 'no subscription' group.

-- Average Duration: The average call duration is around 553 seconds, which is over twice the average duration of calls in the 'no subscription' group.

-- Standard Deviation: A standard deviation of approximately 401 seconds indicates a high variability in call durations, even more so than in the 'no subscription' group.

-- Similar Short Durations: Multiple entries with durations of 63 seconds have the same low percentile rank, suggesting that these are among the shortest calls in the 'subscription' group.

-- General Observations:
-- Longer Calls in Subscription Group: On average, calls that result in a subscription are longer than those that don't. This could suggest that successful conversions require more time, possibly due to more in-depth discussions or better engagement.

-- High Variability: Both groups show high variability in call durations, but the 'subscription' group has a higher average duration, indicating that successful calls might need more time to address customer needs and concerns.

-- Presence of Outliers: The presence of outliers (like the 4918 seconds call) can significantly affect the average duration and should be considered when analyzing the data.
############################################################################################################
-- Question 8
-- How does the frequency of contact in the current campaign impact the likelihood of subscription?
SELECT 
    P.person_id,
    C.campaign AS contacts_during_campaign,
    C.pdays,
    C.previous,
    C.poutcome,
    P.subscribed,
    AVG(C.campaign) OVER (PARTITION BY P.subscribed) AS avg_contacts_subscribed,
    MAX(C.campaign) OVER (PARTITION BY P.subscribed) AS max_contacts_current_campaign,
    MIN(C.campaign) OVER (PARTITION BY P.subscribed) AS min_contacts_current_campaign,
    STDDEV(C.campaign) OVER (PARTITION BY P.subscribed) AS stddev_contacts_current_campaign,
    AVG(C.previous) OVER (PARTITION BY P.subscribed) AS avg_contacts_previous,
    MAX(C.previous) OVER (PARTITION BY P.subscribed) AS max_contacts_previous_campaign,
    MIN(C.previous) OVER (PARTITION BY P.subscribed) AS min_contacts_previous_campaign,
    STDDEV(C.previous) OVER (PARTITION BY P.subscribed) AS stddev_contacts_previous_campaign,
	AVG(CASE WHEN C.pdays <> 999 THEN C.campaign ELSE NULL END) OVER (PARTITION BY P.subscribed) AS avg_pdays,
    MAX(CASE WHEN C.pdays <> 999 THEN C.campaign ELSE NULL END) OVER (PARTITION BY P.subscribed) AS max_pdays,
    MIN(CASE WHEN C.pdays <> 999 THEN C.campaign ELSE NULL END) OVER (PARTITION BY P.subscribed) AS min_pdays,
    STDDEV(CASE WHEN C.pdays <> 999 THEN C.campaign ELSE NULL END) OVER (PARTITION BY P.subscribed) AS stddev_pdays
FROM 
    Campaign C
JOIN 
    Person P ON C.campaign_id = P.campaign_id
GROUP BY 
    P.person_id, C.campaign, C.pdays, C.previous, C.poutcome, P.subscribed
ORDER BY 
    contacts_during_campaign DESC;
-- Median Contacts: For both groups (subscribed and not subscribed), the median number of contacts during the campaign is relatively low, which suggests that most clients were contacted only a few times.

-- Spread and IQR (Interquartile Range): The interquartile range (the height of the boxes), which represents the middle 50% of the data, is also small for both groups. This indicates that there is a general consistency in the number of contacts made to most clients, whether they subscribed or not.

-- Outliers: There are several outliers for both groups, which are the dots outside of the whiskers of the boxplot. These outliers represent clients that were contacted significantly more times than the typical client. In particular, there's an "Extreme Outlier" for a client who did not subscribe, having been contacted 56 times, which is highly unusual compared to the rest of the data.

-- Differences between Groups: There is a visible difference between the 'yes' and 'no' groups in terms of the spread and outliers. The 'no' subscription group has a wider spread and more outliers, suggesting that more attempts were made to contact clients who eventually did not subscribe.

-- Potential Over-contacting: The presence of outliers, especially in the 'no' group, could suggest that too many contacts might lead to client fatigue and therefore not subscribing. It seems that after a certain point, additional contacts do not increase the likelihood of subscription and may, in fact, be counterproductive.

-- Contacts and Subscription Rate: It is not possible to deduce the subscription rate directly from this boxplot. For that, one would need to analyze the proportion of subscribed clients within each contact count category.
#Contact count against sub rate
SELECT 
  c.campaign AS NumberOfContacts, 
  COUNT(p.person_id) AS TotalClients, 
  SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS SubscribedClients, 
  (SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(p.person_id) AS SubscriptionRate
FROM 
  Person p 
JOIN 
  Campaign c ON p.campaign_id = c.campaign_id
GROUP BY 
  c.campaign
ORDER BY 
  c.campaign;
-- Decreasing Subscription Rate with More Contacts: There is a clear trend that as the number of contacts increases, the subscription rate generally decreases. This indicates that the more times a client is contacted, the less likely they are to subscribe. For instance, those contacted once had a subscription rate of about 13.04%, which gradually decreases to 0% for those contacted 16 or more times.

-- Most Effective Contact Frequency: The highest subscription rate is among clients who were contacted only once. This suggests that the campaign is most effective on the first contact and that repeated contacts may not be as effective.

-- Diminishing Returns Beyond a Certain Point: After a certain number of contacts (specifically beyond 6 contacts), the subscription rate falls below 7%, indicating that there might be diminishing returns after this point. It seems that if a client has not subscribed after being contacted 6 times, further contacts are unlikely to be successful.

-- Zero Subscriptions Past a Threshold: From the 16th contact onwards, there are no subscriptions at all. This could suggest that beyond a certain point, additional contacts may potentially have a negative impact or simply be a waste of resources.

-- Small Increases at Certain Points: There are slight increases in subscription rates at the 9th, 11th, and 17th contacts. However, given the overall trend and the small number of clients contacted at these frequencies, these could be anomalies rather than indicative of a pattern.

-- Lowest Subscription Rates: The subscription rates are particularly low (even 0%) for higher numbers of contacts. This might be an indication of either customer fatigue or a strong indication that these clients are not interested in the product.

-- Potential Strategy Adjustment: Considering the above points, it might be beneficial to limit the number of contacts to a client, focusing efforts on the first few contacts, and then re-evaluating the strategy if the client does not subscribe.

-- Optimal Contact Frequency: Based on the highest subscription rates, the optimal number of contacts seems to be 1, with diminishing effectiveness up to 6 contacts. Beyond this, the contact strategy should be reconsidered.
-- To conclude, the strategy might be optimized by focusing on making a strong impression in the initial contacts and limiting the number of follow-up contacts to avoid declining subscription rates and potential customer annoyance.
#Pdays against sub rate  
  SELECT 
  CASE 
    WHEN c.pdays BETWEEN 0 AND 10 THEN '0-10 days'
    WHEN c.pdays BETWEEN 11 AND 20 THEN '11-20 days'
    WHEN c.pdays > 20 AND c.pdays <999 THEN 'more than 20 days'
    WHEN c.pdays = 999 THEN 'Was not previously contacted'
    ELSE 'never contacted'
  END AS PdaysInterval,
  COUNT(p.person_id) AS TotalClients, 
  SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) AS SubscribedClients,
  (SUM(CASE WHEN p.subscribed = 'yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(p.person_id) AS SubscriptionRate
FROM 
  Person p 
JOIN 
  Campaign c ON p.campaign_id = c.campaign_id
GROUP BY 
  PdaysInterval
ORDER BY 
  CASE 
    WHEN PdaysInterval = '0-10 days' THEN 1
    WHEN PdaysInterval = '11-20 days' THEN 2
    WHEN PdaysInterval = 'more than 20 days' THEN 3
    ELSE 4
  END;
-- High Subscription Rate After Recent Contact: Clients contacted between 0-10 days ago have a high subscription rate of approximately 64.91%. This suggests that recent engagement with clients is highly effective for subscriptions.

-- Decrease in Subscription Rate with Time: There is a noticeable decrease in the subscription rate as the time since the last contact increases. For instance, the subscription rate drops to around 55.61% for those contacted 11-20 days ago.

-- Exceptionally High Rate for Sparse Data: The subscription rate for clients contacted more than 20 days ago is very high at 87.50%, but this is based on a very small sample size of only 8 clients. While this suggests that there might be a group of clients who respond well after a longer period, the sample is too small to draw a definitive conclusion and could be an outlier.

-- Lowest Rate for No Previous Contact: Clients who were not previously contacted have the lowest subscription rate of about 9.26%. This could imply that prior contact, regardless of when it occurred, has a significant positive impact on the likelihood of a client subscribing.

-- Importance of Follow-Up: The data shows that follow-up from previous campaigns is crucial. Clients with no previous contact are much less likely to subscribe compared to those with any follow-up, indicating the importance of maintaining customer relationships.

-- Potential Strategy for New Contacts: For clients who have not been previously contacted, a different strategy might be needed compared to those who have been engaged before, as the subscription rate is significantly lower for this group.

-- Reassessing Contact Timing: The data might suggest that waiting too long to re-engage clients (more than 10 days) could result in a lower subscription rate, although clients contacted very recently (0-10 days) show the highest engagement. However, given the high rate of subscriptions for the "more than 20 days" category, it may be worth investigating if there is an optimal time frame for re-contacting certain clients.

-- To sum up, the data indicates that maintaining contact with clients leads to higher subscription rates, with the highest success coming shortly after the previous contact. There is a need to address the strategy for engaging new clients and possibly to explore if there is a more nuanced optimal timing for follow-ups beyond the 20-day mark, despite the small sample size in that category.

