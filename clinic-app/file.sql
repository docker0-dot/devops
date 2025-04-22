-- Таблица для хранения информации о пациентах
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('М', 'Ж')) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица для хранения информации о врачах
CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица для хранения расписания приемов
CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Запланированно', 'Завершенно', 'Отмененно')) DEFAULT 'Запланированно',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Таблица для регистрации пациентов в регистратуре
CREATE TABLE Registration (
    registration_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);

-- Таблица для записи пациентов на прием к врачу
CREATE TABLE PatientAppointments (
    record_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Забронированно', 'Посещенно', 'Пропущенно', 'Отмененно')) DEFAULT 'Забронированно',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);




-- Вставка пациентов
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES
('Иван', 'Иванов', '1985-03-12', 'М', '+79001234567', 'ivanov@example.com', 'г. Москва, ул. Ленина, д. 10'),
('Мария', 'Петрова', '1990-07-25', 'Ж', '+79009876543', 'petrova@example.com', 'г. Санкт-Петербург, пр. Мира, д. 5'),
('Алексей', 'Сидоров', '1978-11-02', 'М', '+79004561234', 'sidorov@example.com', 'г. Казань, ул. Победы, д. 22'),
('Елена', 'Кузнецова', '2000-01-15', 'Ж', '+79007654321', 'kuznecova@example.com', 'г. Екатеринбург, ул. Шевченко, д. 17');

-- Вставка врачей
INSERT INTO Doctors (first_name, last_name, specialty, phone, email)
VALUES
('Ольга', 'Смирнова', 'Терапевт', '+79001112233', 'smirnova@example.com'),
('Дмитрий', 'Ковалев', 'Кардиолог', '+79002223344', 'kovalev@example.com'),
('Анна', 'Лебедева', 'Невролог', '+79003334455', 'lebedeva@example.com');

-- Вставка расписания приемов
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES
(1, 1, '2025-04-23 10:00:00', 'Запланированно'),
(2, 2, '2025-04-23 11:00:00', 'Запланированно'),
(3, 3, '2025-04-24 09:30:00', 'Запланированно'),
(4, 1, '2025-04-24 13:00:00', 'Запланированно');

-- Вставка записей в регистратуре
INSERT INTO Registration (patient_id, notes)
VALUES
(1, 'Обратился впервые, жалобы на головную боль.'),
(2, 'Плановое обследование сердца.'),
(3, 'Хроническая мигрень.'),
(4, 'Повышенное давление.');

-- Вставка записей на прием
INSERT INTO PatientAppointments (patient_id, doctor_id, appointment_id, status)
VALUES
(1, 1, 1, 'Забронированно'),
(2, 2, 2, 'Забронированно'),
(3, 3, 3, 'Забронированно'),
(4, 1, 4, 'Забронированно');