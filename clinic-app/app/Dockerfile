FROM python:3.11-slim

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

# Правильное обновление pip и установка пакетов
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

# Скрипт для запуска миграций и приложения
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
