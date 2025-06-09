#!/bin/sh
# entrypoint.sh

# Устанавливаем переменные окружения
export FLASK_APP=run.py:create_app
export FLASK_RUN_HOST=0.0.0.0

# Если нет каталога migrations, инициализируем его
if [ ! -d "migrations" ]; then
    flask db init
fi

# Выполняем миграции
flask db migrate -m "Initial migration"
flask db upgrade

# Запускаем Flask
flask run
