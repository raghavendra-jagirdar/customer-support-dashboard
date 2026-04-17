# 📊 Customer Support Performance Analysis (SQL + Power BI)
End-to-end analysis of customer support operations to identify inefficiencies and improve resolution performance.

## 📌 Project Overview

This project analyzes customer support ticket data to evaluate operational efficiency, identify trends, and improve customer experience through data-driven insights.

## 🎯 Business Problem

Customer support teams often face high ticket volumes, delayed resolutions, and declining customer satisfaction.
This project analyzes support operations to identify inefficiencies, improve resolution rates, and enhance overall customer experience.

## 📈 Key Findings

* Only ~33% of tickets are resolved, indicating a significant backlog in the support system
* Customer satisfaction averages ~2.99, likely impacted by resolution delays and unresolved tickets
* Chat channel shows slightly higher satisfaction, serving as a potential benchmark for other channels
* A clear drop-off exists between response (~67%) and resolution (~33%), highlighting inefficiencies in ticket lifecycle completion

👉 [View full analysis](sql/insights.md)

## 📐 Key DAX Measures

* Total Tickets = COUNT(ticket_id)
* Resolution Rate = DIVIDE(Closed Tickets, Total Tickets)
* Avg Resolution Time = AVERAGE(resolution_time_minutes)
* Avg Customer Satisfaction = AVERAGE(customer_satisfaction_rating)

## 🎯 Business Objectives

* Analyze ticket volume trends over time
* Identify inefficiencies in resolution time across priorities
* Evaluate customer satisfaction across support channels
* Provide actionable insights to improve support performance

## 📁 Dataset

* 8469 customer support tickets
* Includes ticket priority, channel, resolution time, and satisfaction ratings

## 📊 Key KPIs

* Total Tickets
* Open vs Closed Tickets
* Ticket Volume Trend
* Avg Resolution Time (Minutes)
* Avg Customer Satisfaction

## 🧠 Skills Demonstrated

* Data cleaning and transformation
* Data modeling in Power BI
* DAX for KPI calculations
* Dashboard design and storytelling
* Business insight generation

## 🖼️ Dashboard Preview

### 🔹 Customer Support Performance Overview

![Overview](screenshots/overview.png)

### 🔹 Trends & Analysis

![Trends](screenshots/trends.png)


## 🚀 Tools Used
- Power BI  
- MySQL  
- SQL  
* 🔗 SQL Queries: [View SQL Analysis](sql/customer_support_analysis.sql)

## 📂 Project Structure

* dataset/ → Raw dataset used for analysis
* powerbi/ → Power BI dashboard file (.pbix)
* sql/ → SQL queries and insights
* screenshots/ → Dashboard preview images
