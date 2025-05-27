from flask import Flask, render_template, request, redirect
import psycopg2

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        dbname='clinic',
        user='your_user',
        password='your_password',
        host='localhost'
    )

@app.route('/doctors')
def doctors():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT doctor_id, first_name, last_name, specialty FROM doctors;")
    doctors = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('doctors.html', doctors=doctors)

@app.route('/book', methods=['GET', 'POST'])
def book():
    if request.method == 'POST':
        patient_id = request.form['patient_id']
        doctor_id = request.form['doctor_id']
        date = request.form['date']
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, created_at)
            VALUES (%s, %s, %s, 'pending', NOW());
        """, (patient_id, doctor_id, date))
        conn.commit()
        cur.close()
        conn.close()
        return redirect('/doctors')
    return render_template('appointment_form.html')
