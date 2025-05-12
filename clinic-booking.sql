-- Create a database for a clinic booking system
CREATE DATABASE clinic_db
    DEFAULT CHARACTER SET = 'utf8mb4';
USE clinic_db;

-- Patient table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    insurance_provider VARCHAR(100)
);

-- Medical Staff table
CREATE TABLE medical_staff (
    staff_id INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    specialization VARCHAR(100),
    qualification VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    license_number VARCHAR(50)
);

-- Services table
CREATE TABLE services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(100),
    description TEXT,
    duration INT,
    price DECIMAL(10,2)
);

-- Appointments table
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    appointment_date DATE,
    start_time TIME,
    end_time TIME,
    status VARCHAR(20),
    patient_id INT,
    staff_id INT,
    service_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- Medical Records table
CREATE TABLE medical_records (
    record_id INT PRIMARY KEY,
    record_date DATE,
    diagnosis TEXT,
    patient_id INT,
    staff_id INT,
    appointment_id INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Prescriptions table
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    medication_name VARCHAR(100),
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    record_id INT,
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id)
);

-- Invoices table
CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY,
    invoice_date DATE,
    due_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    appointment_id INT,
    patient_id INT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Invoice Items table
CREATE TABLE invoice_items (
    item_id INT PRIMARY KEY,
    quantity INT,
    unit_price DECIMAL(10,2),
    invoice_id INT,
    service_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    invoice_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);

-- Staff Availability table
CREATE TABLE staff_availability (
    availability_id INT PRIMARY KEY,
    day_of_week VARCHAR(15),
    start_time TIME,
    end_time TIME,
    is_recurring BOOLEAN,
    staff_id INT,
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id)
);

-- Staff Time Off table
CREATE TABLE staff_time_off (
    time_off_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    reason TEXT,
    is_approved BOOLEAN,
    staff_id INT,
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id)
);

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100),
    email VARCHAR(100),
    staff_id INT,
    patient_id INT,
    role VARCHAR(20),
    FOREIGN KEY (staff_id) REFERENCES medical_staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Audit table
CREATE TABLE audit (
    log_id INT PRIMARY KEY,
    action VARCHAR(50),
    table_name VARCHAR(50),
    action_time TIMESTAMP,
    record_id INT,
    user_id INT,
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- Dummy data for patients
INSERT INTO patients VALUES
(1, 'John', 'Doe', '1985-06-15', 'Male', '0712345678', 'john.doe@email.com', 'AAR'),
(2, 'Jane', 'Smith', '1990-09-22', 'Female', '0723456789', 'jane.smith@email.com', 'Jubilee'),
(3, 'Alice', 'Brown', '1978-12-05', 'Female', '0734567890', 'alice.brown@email.com', 'NHIF');

-- Dummy data for medical_staff
INSERT INTO medical_staff VALUES
(1, 'Dr. Mark', 'Green', 'General Practitioner', 'MBChB', '0745678901', 'mark.green@clinic.com', 'DOC123'),
(2, 'Dr. Susan', 'White', 'Dentist', 'BDS', '0756789012', 'susan.white@clinic.com', 'DEN456');

-- Dummy data for services
INSERT INTO services VALUES
(1, 'Consultation', 'General health consultation', 30, 2000.00),
(2, 'Dental Checkup', 'Routine dental examination', 45, 3500.00);

-- Dummy data for appointments
INSERT INTO appointments VALUES
(1, '2025-05-13', '09:00:00', '09:30:00', 'Scheduled', 1, 1, 1),
(2, '2025-05-14', '10:00:00', '10:45:00', 'Scheduled', 2, 2, 2);

-- Dummy data for medical_records
INSERT INTO medical_records VALUES
(1, '2025-05-13', 'Flu symptoms', 1, 1, 1),
(2, '2025-05-14', 'Routine dental check', 2, 2, 2);

-- Dummy data for prescriptions
INSERT INTO prescriptions VALUES
(1, 'Paracetamol', '500mg', 'Twice a day', 1),
(2, 'Ibuprofen', '200mg', 'Once a day', 1);

-- Dummy data for invoices
INSERT INTO invoices VALUES
(1, '2025-05-13', '2025-05-20', 2000.00, 'Unpaid', 1, 1),
(2, '2025-05-14', '2025-05-21', 3500.00, 'Paid', 2, 2);

-- Dummy data for invoice_items
INSERT INTO invoice_items VALUES
(1, 1, 2000.00, 1, 1),
(2, 1, 3500.00, 2, 2);

-- Dummy data for payments
INSERT INTO payments VALUES
(1, '2025-05-14', 3500.00, 'Mpesa', 2);

-- Dummy data for staff_availability
INSERT INTO staff_availability VALUES
(1, 'Monday', '09:00:00', '17:00:00', TRUE, 1),
(2, 'Tuesday', '09:00:00', '17:00:00', TRUE, 2);

-- Dummy data for staff_time_off
INSERT INTO staff_time_off VALUES
(1, '2025-06-01', '2025-06-05', 'Annual leave', TRUE, 1);

-- Dummy data for users
INSERT INTO users VALUES
(1, 'admin', 'hashedpassword1', 'admin@clinic.com', 1, NULL, 'admin'),
(2, 'jane_smith', 'hashedpassword2', NULL, NULL, 2, 'patient');

-- Dummy data for audit
INSERT INTO audit VALUES
(1, 'INSERT', 'appointments', '2025-05-13 09:05:00', 1, 1),
(2, 'UPDATE', 'invoices', '2025-05-14 11:00:00', NULL, 1);


-- Indexes for performance optimization
-- Patients
CREATE INDEX idx_patients_email ON patients(email);
-- Staff Availability
CREATE INDEX idx_staff_availability_staff_id ON staff_availability(staff_id);
-- Staff Time Off
CREATE INDEX idx_staff_time_off_staff_id ON staff_time_off(staff_id);
-- Users
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_staff_id ON users(staff_id);
CREATE INDEX idx_users_patient_id ON users(patient_id);

-- Audit
CREATE INDEX idx_audit_user_id ON audit(user_id);
CREATE INDEX idx_audit_record_id ON audit(record_id);
CREATE INDEX idx_audit_action_time ON audit(action_time);

-- View: Upcoming Appointments with Patient and Staff Details
CREATE VIEW view_upcoming_appointments AS
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.start_time,
    a.end_time,
    a.status,
    p.firstname AS patient_firstname,
    p.lastname AS patient_lastname,
    s.firstname AS staff_firstname,
    s.lastname AS staff_lastname,
    sv.service_name
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN medical_staff s ON a.staff_id = s.staff_id
JOIN services sv ON a.service_id = sv.service_id
WHERE a.appointment_date >= CURDATE();

-- View: Staff Availability by Day
CREATE VIEW view_staff_availability_by_day AS
SELECT
    ms.staff_id,
    ms.firstname,
    ms.lastname,
    sa.day_of_week,
    sa.start_time,
    sa.end_time,
    sa.is_recurring
FROM medical_staff ms
JOIN staff_availability sa ON ms.staff_id = sa.staff_id;