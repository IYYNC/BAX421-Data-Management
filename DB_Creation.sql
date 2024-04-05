-- Create a new database
CREATE DATABASE BankMarketingDB;

-- Select the database to use
USE BankMarketingDB;

-- Create Job table
CREATE TABLE Job (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(255) NOT NULL
);

-- Create Education table
CREATE TABLE Education (
    education_id INT AUTO_INCREMENT PRIMARY KEY,
    education_level VARCHAR(255) NOT NULL
);

-- Create Loan table
CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    housing VARCHAR(50),
    personal_loan VARCHAR(50)
);

-- Create Contact table
CREATE TABLE Contact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    contact_type VARCHAR(50),
    month VARCHAR(50),
    day_of_week VARCHAR(50),
    duration INT
);

-- Create Economic table
CREATE TABLE Economic (
    economic_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_var_rate FLOAT,
    cons_price_idx FLOAT,
    cons_conf_idx FLOAT,
    euribor3m FLOAT,
    nr_employed INT
);

-- Create Campaign table
CREATE TABLE Campaign (
    campaign_id INT AUTO_INCREMENT PRIMARY KEY,
    campaign VARCHAR(255),
    pdays INT,
    previous INT,
    poutcome VARCHAR(255)
);

-- Create Person table
CREATE TABLE Person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT,
    job_id INT,
    education_id INT,
    loan_id INT,
    contact_id INT,
    campaign_id INT,
    economic_id INT,
    marital_status VARCHAR(50),
    subscribed VARCHAR(50), -- 'y' column indicating subscription status
    FOREIGN KEY (job_id) REFERENCES Job(job_id),
    FOREIGN KEY (education_id) REFERENCES Education(education_id),
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id),
    FOREIGN KEY (contact_id) REFERENCES Contact(contact_id),
    FOREIGN KEY (campaign_id) REFERENCES Campaign(campaign_id),
    FOREIGN KEY (economic_id) REFERENCES Economic(economic_id)
);
  