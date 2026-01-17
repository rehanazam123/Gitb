# FAST_BACKEND/Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# OS deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    default-libmysqlclient-dev \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first for caching
COPY requirements.txt /app/requirements.txt

RUN python -m pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application
COPY . /app

# copy helper scripts
COPY wait-for.sh /app/wait-for.sh
COPY entrypoint.sh /app/entrypoint.sh
COPY create_db.py /app/create_db.py
RUN chmod +x /app/wait-for.sh /app/entrypoint.sh

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["/app/entrypoint.sh"]
