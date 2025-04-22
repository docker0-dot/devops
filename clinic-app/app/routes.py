from flask import Blueprint, jsonify
from .models import Patient

main = Blueprint('main', __name__)

@main.route('/')
def home():
    return {'message': 'Добро пожаловать в Clinic API!'}

@main.route('/check')
def check():
    return jsonify([p.first_name for p in Patient.query.limit(5).all()])
