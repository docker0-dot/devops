from flask_sqlalchemy import SQLAlchemy

from datetime import datetime
from main import db

# 🧑‍⚕️ Врачи
class Doctor(db.Model):
    __tablename__ = 'doctors'

    doctor_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    specialty = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(20))
    email = db.Column(db.String(100))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

# 🧍 Пациенты
class Patient(db.Model):
    __tablename__ = 'patients'

    patient_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    date_of_birth = db.Column(db.Date)
    gender = db.Column(db.String(10))
    phone = db.Column(db.String(20))
    email = db.Column(db.String(100))
    address = db.Column(db.String(200))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

# 🗓️ Записи на приём
class Appointment(db.Model):
    __tablename__ = 'appointments'

    appointment_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id'), nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id'), nullable=False)
    appointment_date = db.Column(db.DateTime, nullable=False)
    status = db.Column(db.String(50), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

# 📄 Таблица связей записей
class PatientAppointment(db.Model):
    __tablename__ = 'patientappointments'

    record_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id'), nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id'), nullable=False)
    appointment_id = db.Column(db.Integer, db.ForeignKey('appointments.appointment_id'), nullable=False)
    booking_date = db.Column(db.DateTime, default=datetime.utcnow)
    status = db.Column(db.String(50), nullable=False)

# 📝 Регистрации пациентов
class Registration(db.Model):
    __tablename__ = 'registration'

    registration_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id'), nullable=False)
    registration_date = db.Column(db.DateTime, default=datetime.utcnow)
    notes = db.Column(db.Text)

# 🔬 Тестовая таблица (возможно для отладки)
class Test(db.Model):
    __tablename__ = 'test'

    test_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100))
