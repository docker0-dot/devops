from flask import Blueprint, render_template, request, redirect, url_for
import psycopg2
from datetime import datetime
from datetime import datetime
from urllib.parse import quote_plus

# Создаем Blueprint вместо использования app напрямую
bp = Blueprint('main', __name__)

# 📄 Страница со списком врачей
@bp.route('/doctors')
def doctors():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT doctor_id, first_name, last_name, specialty FROM doctors')
    doctors = [dict(doctor_id=row[0], first_name=row[1], last_name=row[2], specialty=row[3]) for row in cur.fetchall()]
    cur.close()
    conn.close()
    return render_template('doctors.html', doctors=doctors)

# 📝 Форма записи на приём
@bp.route('/appointment', methods=['GET', 'POST'])
def appointment():
    conn = get_db_connection()
    cur = conn.cursor()

    # Получение списка пациентов и врачей
    cur.execute('SELECT patient_id, first_name, last_name FROM patients')
    patients = [dict(patient_id=r[0], first_name=r[1], last_name=r[2]) for r in cur.fetchall()]

    cur.execute('SELECT doctor_id, first_name, last_name, specialty FROM doctors')
    doctors = [dict(doctor_id=r[0], first_name=r[1], last_name=r[2], specialty=r[3]) for r in cur.fetchall()]

    success = False

    if request.method == 'POST':
        patient_id = request.form['patient_id']
        doctor_id = request.form['doctor_id']
        appointment_date = request.form['appointment_date']
        now = datetime.now()

        # 1. Создать запись в таблице appointments
        cur.execute("""
            INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, created_at)
            VALUES (%s, %s, %s, %s, %s) RETURNING appointment_id
        """, (patient_id, doctor_id, appointment_date, 'Запланировано', now))
        appointment_id = cur.fetchone()[0]

        # 2. Создать запись в patientappointments
        cur.execute("""
            INSERT INTO patientappointments (patient_id, doctor_id, appointment_id, booking_date, status)
            VALUES (%s, %s, %s, %s, %s)
        """, (patient_id, doctor_id, appointment_id, now, 'Активна'))

        conn.commit()
        success = True

    cur.close()
    conn.close()
    return render_template('appointment_form.html', patients=patients, doctors=doctors, success=success)

# 📃 Список всех записей
@bp.route('/appointments')
def appointment_list():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT p.first_name || ' ' || p.last_name AS patient_name,
               d.first_name || ' ' || d.last_name AS doctor_name,
               a.appointment_date,
               a.status
        FROM appointments a
        JOIN patients p ON a.patient_id = p.patient_id
        JOIN doctors d ON a.doctor_id = d.doctor_id
        ORDER BY a.appointment_date DESC
    """)
    appointments = [dict(patient_name=r[0], doctor_name=r[1], appointment_date=r[2], status=r[3]) for r in cur.fetchall()]
    cur.close()
    conn.close()
    return render_template('appointments.html', appointments=appointments)
