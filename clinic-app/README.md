# 🏥 Clinic App (Flask + PostgreSQL + Docker)

Это простое клиент-серверное приложение для клиники на Flask с подключением к PostgreSQL через Docker.

## 🚀 Как запустить
  -- bash
  git clone https://github.com/your-name/clinic-app.git
  cd clinic-app
  docker-compose up --build
  -- После запуска приложение будет доступно по адресу:
  http://localhost:5000

## 📦 Состав
  * Flask API
  * PostgreSQL база
  * Docker + docker-compose
  * Поддержка автообновления при изменении кода

## ⚙️ Переменные окружения
    Файл .env:
    DATABASE_URL=postgresql://postgres:postgres@db:5432/clinic

## 🗃 Структура базы данных
    Приложение использует следующие таблицы:
      * Patients — информация о пациентах
      * Doctors — информация о врачах
      * Appointments — расписание приемов
      * Registration — регистрация пациентов
      * PatientAppointments — записи на прием
  SQL-структура описана в app/models.py.


## 📂 Структура проекта
    clinic-app/
    ├── app/
    │   ├── __init__.py         # Создание Flask-приложения
    │   ├── routes.py           # Роуты API
    │   └── models.py           # SQLAlchemy модели
    ├── init_db.py              # Скрипт для инициализации базы
    ├── requirements.txt        # Зависимости Python
    ├── Dockerfile              # Сборка Flask-приложения
    ├── docker-compose.yml      # Docker + PostgreSQL
    ├── .env                    # Переменные окружения
    └── README.md               # Этот файл


## 🛠 Полезные команды
    Создание таблиц (один раз после первого запуска):
    docker-compose exec web python init_db.py
    Остановка:
    docker-compose down

## 🧪 Пример запроса
    Проверь подключение к базе:
    -- http
    GET /check
