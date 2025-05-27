from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def hello():
    try:
        conn = psycopg2.connect(
            dbname=os.getenv('clinic'),
            user=os.getenv('postgres'),
            password=os.getenv('96wo784W'),
            host=os.getenv('127.0.0.1'),
            port=os.getenv('5432')
        )
        return "Connected to the database!"
    except Exception as e:
        return f"Error: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
