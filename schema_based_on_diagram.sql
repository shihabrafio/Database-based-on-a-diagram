CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);


CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history__id INT
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history__id INT
);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR,
    name VARCHAR
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR
);

CREATE TABLE medical_treatment (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    treatment_id INT,
    medical_history__id INT
);

CREATE INDEX invoice_items_invoice_id_idx ON invoice_items(invoice_id);
CREATE INDEX invoice_items_treatment_id_idx ON invoice_items(treatment_id);

CREATE INDEX invoices_medical_history_id_idx ON invoices(medical_history__id);

CREATE INDEX helper_table_med_history_id_idx ON medical_treatment(treatment_id);
CREATE INDEX helper_table_treatment_id_idx ON medical_treatment(medical_history__id);

CREATE INDEX medical_histories_patient_id_idx ON medical_histories(patient_id);

ALTER TABLE invoice_items ADD CONSTRAINT invoice_items_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES invoices (id);
ALTER TABLE invoice_items ADD CONSTRAINT invoice_items_treatment_id_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id);
ALTER TABLE invoices ADD CONSTRAINT invoices_medical_history_id_fkey FOREIGN KEY (medical_history__id) REFERENCES medical_histories (id);
ALTER TABLE medical_treatment ADD CONSTRAINT helper_table_med_history_id_fkey FOREIGN KEY (medical_history__id) REFERENCES medical_histories (id);
ALTER TABLE medical_treatment ADD CONSTRAINT helper_table_treatment_id_fkey FOREIGN KEY (treatment_id) REFERENCES treatments (id);
ALTER TABLE medical_histories ADD CONSTRAINT medical_histories_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients (id);