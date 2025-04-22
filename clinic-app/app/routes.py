from flask import Blueprint, jsonify
from .models import Patient

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return jsonify({"message": "Привет из клиники!"})

@main.route('/patients')
def get_patients():
    return jsonify([{"id": p.id, "name": p.name} for p in Patient.query.all()])