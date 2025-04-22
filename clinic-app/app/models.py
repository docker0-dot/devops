from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Patient(db.Model):
    __tablename__ = 'patients'
    __table_args__ = {'extend_existing': True}

    patient_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    date_of_birth = db.Column(db.Date, nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    phone = db.Column(db.String(20))
    email = db.Column(db.String(100))
    address = db.Column(db.Text)
    created_at = db.Column(db.DateTime, server_default=db.func.current_timestamp())


class Doctor(db.Model):
    __tablename__ = 'doctors'
    __table_args__ = {'extend_existing': True}

    doctor_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    specialty = db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(20))
    email = db.Column(db.String(100))
    created_at = db.Column(db.DateTime, server_default=db.func.current_timestamp())


class Appointment(db.Model):
    __tablename__ = 'appointments'
    __table_args__ = {'extend_existing': True}

    appointment_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id', ondelete='CASCADE'), nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id', ondelete='CASCADE'), nullable=False)
    appointment_date = db.Column(db.DateTime, nullable=False)
    status = db.Column(db.String(20), default='Запланированно')
    created_at = db.Column(db.DateTime, server_default=db.func.current_timestamp())


class Registration(db.Model):
    __tablename__ = 'registration'
    __table_args__ = {'extend_existing': True}

    registration_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id', ondelete='CASCADE'), nullable=False)
    registration_date = db.Column(db.DateTime, server_default=db.func.current_timestamp())
    notes = db.Column(db.Text)


class PatientAppointment(db.Model):
    __tablename__ = 'patientappointments'
    __table_args__ = {'extend_existing': True}

    record_id = db.Column(db.Integer, primary_key=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.patient_id', ondelete='CASCADE'), nullable=False)
    doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id', ondelete='CASCADE'), nullable=False)
    appointment_id = db.Column(db.Integer, db.ForeignKey('appointments.appointment_id', ondelete='CASCADE'), nullable=False)
    booking_date = db.Column(db.DateTime, server_default=db.func.current_timestamp())
    status = db.Column(db.String(20), default='Забронированно')
