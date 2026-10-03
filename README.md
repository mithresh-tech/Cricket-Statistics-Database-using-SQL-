# 🏏 Cricket Statistics Database – SQL Project

## 📌 Project Overview

The Cricket Statistics Database is a relational database project developed using MySQL.

The project is designed to store, manage, validate, and analyze cricket-related information such as teams, players, venues, matches, batting statistics, and bowling statistics.

The database demonstrates practical implementation of SQL and database concepts including relational database design, constraints, joins, aggregate functions, subqueries, CTEs, window functions, stored procedures, functions, views, triggers, transactions, exception handling, and indexing.

---

## 🎯 Project Objectives

- Design a structured relational database for cricket statistics.
- Maintain team, player, venue, match, batting, and bowling information.
- Establish relationships between database tables using Primary Keys and Foreign Keys.
- Maintain data integrity using constraints and validation.
- Perform player and team performance analysis using SQL queries.
- Create reusable Stored Procedures and User-Defined Functions.
- Implement Triggers for validation and audit logging.
- Generate reports using SQL Views and Stored Procedures.
- Improve query performance using indexes.
- Demonstrate transaction management using COMMIT, ROLLBACK, and SAVEPOINT.

---

## 🛠️ Technologies Used

- MySQL
- SQL
- MySQL Workbench
- Relational Database Management System (RDBMS)

---

## 🗄️ Database Structure

Database Name:

`CricketStatisticsDB`

### Core Tables

1. `Teams`
2. `Players`
3. `Venues`
4. `Matches`
5. `Batting_Statistics`
6. `Bowling_Statistics`
7. `Player_Audit`

### Table Relationships

- Teams → Players
- Teams → Matches
- Venues → Matches
- Matches → Batting_Statistics
- Matches → Bowling_Statistics
- Players → Batting_Statistics
- Players → Bowling_Statistics
- Players → Player_Audit

The database uses Primary Keys and Foreign Keys to maintain relationships between tables.

---

## 📊 Database Features

### 1. Database & Table Creation

The project creates a dedicated database named `CricketStatisticsDB` and defines relational tables with appropriate data types, constraints, and relationships.

### 2. Data Integrity

The following constraints are implemented:

- Primary Key
- Foreign Key
- NOT NULL
- UNIQUE
- CHECK
- DEFAULT

Examples include validation of player roles, gender values, match teams, and non-negative performance statistics.

---

## 🔍 SQL Concepts Implemented

### Basic SQL

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING

### Intermediate SQL

- INNER JOIN
- LEFT JOIN
- Aggregate Functions
- Date Functions
- Filtering and Sorting

### Advanced SQL

- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- ROW_NUMBER()
- DENSE_RANK()
- LAG()
- LEAD()            
- PARTITION BY

---

## ⚙️ Stored Procedures

The project includes reusable Stored Procedures for database operations such as:

- Adding player records
- Updating player records
- Deleting player records
- Searching player records
- Detailed player reports
- Summary reports
- Monthly/Yearly reports
- Top-N player analysis
- Category-wise analysis
- Business validation

Stored Procedures also demonstrate transactions and exception handling.

---

## 🧮 User-Defined Functions

The project implements functions for reusable calculations and information retrieval, including:

- Total runs of a player
- Total wickets of a player
- Average runs
- Player run category
- Player batting style
- Player role
- Matches played by year
- Player debut year
- Player name
- Player bowling style

---

## ⚡ Triggers

Triggers are used for validation and audit logging.

### Validation Triggers

- Player insert validation
- Batting update validation
- Player delete validation

### Audit Triggers

- After Player Insert
- After Player Update
- After Player Delete

The `Player_Audit` table stores the audit information automatically when player records are inserted, updated, or deleted.

---

## 📑 SQL Views

Views are created to simplify reporting and analysis.

Examples include:

- Player Details
- Player Batting Performance
- Player Bowling Performance
- Top Run Scorers
- Team Performance
- Team Bowling Performance
- Complete Player Performance
- Match Details
- Match Venue Summary
- Match Type Summary

---

## 🚀 Performance Optimization

Indexes are created on frequently searched and joined columns.

Examples:

- Player Name
- Player Team ID
- Match Date
- Team Name
- Venue Name
- Batting Player ID
- Bowling Player ID

These indexes help improve query performance for searching, filtering, and joining operations.

---

## 🔄 Transaction Management

The project demonstrates transaction control using:

```sql
START TRANSACTION;
COMMIT;
ROLLBACK;
SAVEPOINT;
ROLLBACK TO SAVEPOINT;
