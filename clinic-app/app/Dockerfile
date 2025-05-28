FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Скрипт для запуска миграций и приложения
COPY entrypoint.sh .
RUN chmod +x /app/entrypoint.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
