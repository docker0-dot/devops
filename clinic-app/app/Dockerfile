FROM python:3.11-slim

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app/app
CMD ["python", "main.py"]
