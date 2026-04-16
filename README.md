# Spotify Churn Analysis and Retention Strategy

## Project Overview
This project analyzes user behavior data from a Spotify-like platform to understand customer churn patterns and develop a data-driven retention strategy.

The objective is to identify users at risk of churn and recommend targeted actions to improve user retention.

---

## Objectives
- Analyze user engagement and behavior
- Identify key factors influencing churn
- Segment users based on churn risk
- Build a rule-based churn prediction model
- Develop actionable retention strategies

---

## Dataset Description

The dataset contains user-level information including:

- user_id – Unique identifier for each user  
- gender, age, country – Demographic details  
- subscription_type – Free, Premium, Family, Student  
- listening_time – Total listening duration  
- songs_played_per_day – Daily engagement level  
- skip_rate – Percentage of skipped songs  
- device_type – Mobile, Desktop, Web  
- ads_listened_per_week – Weekly ad exposure  
- offline_listening – Offline usage (0/1)  
- is_churned – Target variable (1 = churned, 0 = active)

---

## Tools and Technologies
- SQL (MySQL)
- Data Analysis and Aggregation
- Business Logic Modeling

---

## Exploratory Data Analysis
- Calculated overall churn rate
- Analyzed churn by subscription type, device type, and demographics
- Compared behavioral metrics between churned and active users
- Identified weak correlation of individual features with churn

---

## Key Insights
- Individual features such as listening time and skip rate showed limited impact when analyzed independently
- Churn behavior is influenced more by a combination of user engagement factors
- Skip rate emerged as the strongest behavioral indicator of churn
- Mobile users and student segments showed relatively higher churn tendencies

---

## Churn Risk Segmentation Model

A rule-based model was developed using SQL to classify users into risk categories:

- High Risk: skip_rate > 0.5 AND songs_played_per_day < 40  
- Medium Risk: skip_rate > 0.4  
- Low Risk: Remaining users  

The model was iteratively refined to ensure proper separation between risk groups.

---

## Model Evaluation

Risk segmentation results:

- High Risk users showed the highest churn rate  
- Medium Risk users showed moderate churn  
- Low Risk users showed the lowest churn  

This confirms the effectiveness of behavioral segmentation.

---

## Retention Strategy

Based on risk categories, targeted actions were defined:

- High Risk → Offer discounts or incentives  
- Medium Risk → Send engagement notifications and recommendations  
- Low Risk → No immediate action required  

This approach enables cost-effective and targeted retention strategies.

---

## Conclusion
The project demonstrates that combining behavioral features provides better insights into churn than analyzing individual metrics.

A simple and interpretable rule-based model can effectively segment users and support business decision-making.

---

## Future Improvements
- Build a machine learning model (Logistic Regression, Random Forest)
- Perform feature importance analysis
- Develop a dashboard using Power BI or Tableau
- Incorporate time-based user behavior trends

---

## Author
**Ajay Tiwari**  
tiwariajay110125@gmail.com  
LinkedIn: https://www.linkedin.com/in/ajay-tiwari-849725284/  
Portfolio: https://ajay-tiwari94-portfolio.vercel.app/  