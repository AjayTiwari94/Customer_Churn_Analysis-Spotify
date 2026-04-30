create database spotify;
use spotify;

show tables;
select * from churning;

-- 12 columns - id, gender, age, country, subscription_type,listening_time, songs_played_per_day,skip_rate, device_type, ads_listened_per_week, offline_listening, is_churned
-- 8000 rows returned

select gender from churning 
group by gender;
-- no error

select country from churning
group by country;
-- only 8 countries: CA,DE,AU,US,UK,IN,FR,PK

SELECT * FROM CHURNING;

SELECT SUBSCRIPTION_TYPE FROM CHURNING
GROUP BY 1;
-- ALREADY CLEAN

SELECT DEVICE_TYPE FROM CHURNING
GROUP BY 1;
-- CLEAN
-- ischurned =1 user left spotify

select count(*) no_of_people_left from churning
where is_churned=1;
-- 2071 people already left spotify out of 8000 people

select round(count(is_churned)/(select count(*) from churning)*100,2) as churned_percentage from churning
where is_churned=1;
-- 25.89 percent

select subscription_type, round(count(is_churned)/(select count(*) from churning)*100,2) as churned_percentage from churning
where is_churned=1 group by 1 
order by 2 desc;

select floor((age/10))*10 as age_group, count(*) from churning
group by 1
order by 2 desc;

-- age group 50-60 and 40-50 have the same number of churned people

select 
    floor(age/10)*10 as age_group,
    count(*) as total_users,
    sum(is_churned=1) as churned_users,
    round(sum(is_churned)*100.0 / COUNT(*),2) as churn_rate
from churning
group by 1
order by churn_rate desc;

select country,count(*) from churning
group by 1
order by 2 desc;

-- AU > US > DE > IN > PK > FR > UK > CA
-- 1034>1032>1015>1011>999 >989 >966 >954


select 
case
	when is_churned=1 then 'churned'
    else 'not churned'
end as churn_status, avg(listening_time) from churning
group by 1;
-- churned people have lesser average listening time
-- churn_status, avg_listening_time
#  churned       152.9845            
#  not churned   154.4468

select case
	when is_churned = 1 then 'churned'
	else 'not churned'
end as churn_status, 
avg(listening_time) as avg_listening_time,
avg(skip_rate) as avg_skip_rate,
avg(songs_played_per_day) as avg_songs
from churning
group by churn_status;
-- all value are almost the same, none of the factor is much differntaiting
-- churn_status, avg_listening_time, avg_skip_rate,        avg_songs
#  churned       152.9845            0.30486238532110027   50.5756
#  not churned   154.4468            0.29847360431775594   49.9707

select 
    subscription_type,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned)*100.0/count(*), 2) as churn_rate
from churning
group by subscription_type
order by churn_rate desc;

-- subscription_type, total_users, churned_users, churn_rate
#  Family             1908         525            27.52
#  Student            1959         513            26.19
#  Premium            2115         530            25.06
#  Free               2018         503            24.93

select case 
	when ads_listened_per_week > 20 then 'High Ads'
	else 'Low Ads'
end as ad_category,
round(sum(is_churned)*100.0/count(*),2) as churn_rate
from churning
group by 1;

select 
    subscription_type,
    device_type,
    round(sum(is_churned)*100.0/count(*),2) as churn_rate
from churning
group by subscription_type, device_type
order by churn_rate desc;

select *
from churning
where is_churned = 1
order by skip_rate desc, listening_time asc;


select *,
case 
    when skip_rate > 0.5 and songs_played_per_day < 20 then 'high risk'
    when skip_rate > 0.4 then 'medium risk'
    else 'low risk'
end as risk_category
from churning;
-- printed the data with the category in which the data lie



select 
    risk_category,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned)*100.0/count(*),2) as churn_rate
from (
    select *,
    case
        when skip_rate > 0.5 and songs_played_per_day < 20 then 'high risk'
        when skip_rate > 0.4 then 'medium risk'
        else 'low risk'
    end as risk_category
    from churning
) t
group by risk_category
order by churn_rate desc;


select 
    risk_category,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned)*100.0/count(*),2) as churn_rate
from (
    select *,
    case
		when skip_rate > 0.5 and songs_played_per_day < 20 then 'high risk'
		when skip_rate > 0.4 or listening_time < 50 then 'medium risk'
		else 'low risk'
    end as risk_category
    from churning
) t
group by risk_category
order by churn_rate desc;


select 
    risk_category,
    count(*) as total_users,
    sum(is_churned) as churned_users,
    round(sum(is_churned)*100.0/count(*),2) as churn_rate
from (
    select *,
    case
    when skip_rate > 0.5 
         and songs_played_per_day < 40 then 'high risk'
         
    when skip_rate > 0.4 then 'medium risk'
    
    else 'low risk'
end as risk_category
	from churning
) t
group by risk_category
order by churn_rate desc;

-- risk_category, Total_users, churned_users, churn_rate
 # high risk       492         140           28.46
 # medium risk     2106        559           26.54
 # low risk        5402        1372          25.40

select 
    risk_category,
    retention_strategy,
    count(*) as users
from (
    select *,
    case
        when skip_rate > 0.5 and songs_played_per_day < 40 then 'high risk'
        when skip_rate > 0.4 then 'medium risk'
        else 'low risk'
    end as risk_category,
    
    case
        when skip_rate > 0.5 and songs_played_per_day < 40 then 'offer discount'
        when skip_rate > 0.4 then 'send engagement notification'
        else 'no action'
    end as retention_strategy
    
    from churning
) t
group by risk_category, retention_strategy;

-- 5402 low risk
-- 2106 medium risk
-- 492 high risk
