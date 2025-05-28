#!/bin/sh
# entrypoint.sh

# Устанавливаем переменную FLASK_APP для миграций
export FLASK_APP=app.main

export FLASK_RUN_HOST=0.0.0.0
# Выполняем миграции
flask db upgrade
flask run

# Запускаем приложение
exec python app/main.py

