#!/bin/sh
# entrypoint.sh

# Устанавливаем переменную FLASK_APP для миграций
export FLASK_APP=main.py

# Выполняем миграции
flask db upgrade

# Запускаем приложение
exec python main.py
