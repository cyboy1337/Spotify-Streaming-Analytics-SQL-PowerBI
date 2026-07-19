# Spotify-Streaming-Analytics-SQL-PowerBI
End-to-end Spotify Streaming Analytics project showcasing SQL analysis, SQL Views, and Power BI visualization for Business Intelligence and data-driven decision making.

**Portfolio Project 2 - SQL & Power BI - Spotify Streaming Analytics**

In this end-to-end **Business Intelligence** project, I imported a multi-table Spotify streaming dataset into **MySQL**, performed business analysis using SQL, created reusable SQL Views for **KPIs and analytical reporting**, and visualized the results in an **interactive Power BI dashboard**. The objective of this project is to demonstrate how SQL can be used to transform raw streaming data into meaningful business insights while leveraging Power BI as a visualization and reporting tool.

# Project Guide

The project consists of three related CSV datasets containing Users, Tracks, and Artists information. I first imported these datasets into MySQL and established the necessary relationships to create a relational database for analysis.

Rather than performing calculations inside Power BI, I implemented the complete business logic using SQL by creating separate **SQL Views** for each **KPI, trend, and analytical requirement**. These SQL Views serve as the data source for the dashboard, resulting in a scalable, efficient, and well-structured reporting layer.

After completing the SQL analysis, I connected the MySQL database directly to **Power BI** and imported all SQL Views. Inside Power BI, I designed an **interactive dashboard** using **KPI cards, bar charts, line charts, donut charts, tables, slicers, and cross-filtering** to present the SQL-generated insights in a visually appealing and business-friendly format.

This project demonstrates an end-to-end **Business Intelligence** workflow where MySQL is used for data transformation and business analysis, while Power BI is used exclusively for **dashboard** development and **interactive data visualization**.

# SQL Concepts Used

Throughout this project, I used several SQL concepts to perform business analysis, including:

- Month-over-Month (MoM) Growth Analysis
- Common Table Expressions (CTEs)
- JOIN Operations
- Window Functions
- Ranking Functions (DENSE_RANK)
- Top N Analysis
- LAG Function
- Percentage Calculations
- GROUP BY
- Aggregate Functions
- CASE Statements
- Date Functions
- SQL Views
- Data Aggregation
- Relational Database Analysis

Most of the business logic has been implemented using SQL before connecting the data to Power BI.

# Dashboard Preview

<img width="604" height="338" alt="image" src="https://github.com/user-attachments/assets/b9eed837-98b5-4625-8545-a024222b556f" />

# Project Files

This repository contains the following files:

- **Spotify.sql** — Complete SQL script containing all SQL queries, Common Table Expressions (CTEs), SQL Views, KPI calculations, and business analysis used throughout the project.
- **Spotify_Dashboard.pbix** — Interactive Power BI dashboard built using SQL Views imported from MySQL.
- **Users.csv** — User information dataset containing demographic and subscription details.
- **Tracks.csv** — Track-level dataset containing streaming activity and listening metrics.
- **Artists.csv** — Artist information dataset used for artist and genre analysis.
- **README.md** — Project documentation.
