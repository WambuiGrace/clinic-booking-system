# Clinic Booking System Database

## Description

This project provides a comprehensive SQL database schema for a clinic booking system. It manages patient records, staff details, appointments, services, medical records, prescriptions, invoicing, payments, staff availability, user accounts, and audit logs. The database is designed to streamline clinic operations, support appointment scheduling, billing, and maintain a complete medical and administrative record for both patients and staff.

## Setup Instructions

1. **Clone or Download the Project**
   - Download or clone this repository to your local machine.

2. **Open Your SQL Client**
   - Use MySQL Workbench or VS Code with a SQL extension.

3. **Import the Database**
   - Open the `clinic-booking.sql` file located in the project directory.
   - Run the script to create the database, tables, insert dummy data, create indexes, and views.

   ```sql
   mysql -u <your_username> -p < clinic.sql
   ```

4. **Verify the Setup**
   - After running the script, you should see the `clinic_db` database with all tables, sample data, indexes, and views.

## Entity Relationship Diagram (ERD)

You can view the ERD for this project here:

[Clinic Booking System ERD (SVG)](clinic.svg)

---
**Note:**  
- Make sure your MySQL server supports the `utf8mb4` character set.