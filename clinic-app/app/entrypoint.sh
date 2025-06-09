#!/bin/sh
# entrypoint.sh

# Устанавливаем переменные окружения
export FLASK_APP=run.py
export FLASK_RUN_HOST=0.0.0.0

# Если нет каталога migrations, инициализируем его
if [ ! -d "migrations" ]; then
    flask db init
    flask db migrate -m "Initial migration"
fi

# Выполняем миграции
flask db upgrade

# Запускаем Flask
exec flask run
