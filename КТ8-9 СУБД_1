-- Создание таблиц
CREATE TABLE Patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    birth_date DATE
);

CREATE TABLE Doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    specialty VARCHAR(100)
);

CREATE TABLE Drugs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    is_prescription_only BOOLEAN DEFAULT TRUE
);

CREATE TABLE Prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_number VARCHAR(50) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    issue_date DATE NOT NULL,
    validity_period INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(id)
);

CREATE TABLE Prescription_Items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    drug_id INT NOT NULL,
    dosage VARCHAR(100),
    daily_dose VARCHAR(100),
    total_quantity DECIMAL(10, 2) NOT NULL,
    quantity_unit VARCHAR(20),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(id),
    FOREIGN KEY (drug_id) REFERENCES Drugs(id)
);

CREATE TABLE Prescription_Sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_item_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity_sold DECIMAL(10, 2) NOT NULL,
    remaining_quantity DECIMAL(10, 2),
    FOREIGN KEY (prescription_item_id) REFERENCES Prescription_Items(id)
);
-- Сначала удаляем таблицы, которые имеют внешние ключи (зависимые)
DROP TABLE IF EXISTS Prescription_Sales;
DROP TABLE IF EXISTS Prescription_Items;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Drugs;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Medical_Institutions;
