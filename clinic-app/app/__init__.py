from flask import Flask
from .extensions import db, migrate
from urllib.parse import quote_plus

def create_app():
    app = Flask(__name__, template_folder='templates')
    
    # Конфигурация
    username = 'postgres'
    password = '96wo784W'
    host = '192.168.0.100'
    dbname = 'clinic'

    app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://{username}:{password}@{host}:5432/{dbname}'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
    # Инициализация расширений
    db.init_app(app)
    migrate.init_app(app, db)
    
    # Импорт маршрутов
    from .main import bp as main_bp
    app.register_blueprint(main_bp)
    
    # Импорт маршрутов и моделей
    from . import models
    
    return app
