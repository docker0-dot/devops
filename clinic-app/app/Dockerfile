FROM python:3.11-slim

# Создаем директорию и переходим в нее
WORKDIR /app

# Копируем все файлы проекта в контейнер
COPY . .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем рабочую директорию на /app/app
WORKDIR /app/app

# Запускаем приложение
CMD ["python", "main.py"]
