#!/bin/sh
# entrypoint.sh

# Устанавливаем переменную FLASK_APP для миграций
export FLASK_APP=main.py

export FLASK_RUN_HOST=0.0.0.0
# Выполняем миграции
flask db upgrade
flask run

# Запускаем приложение
exec python main.py

