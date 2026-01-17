FROM python:3.10-slim

WORKDIR /app

# Copy requirements and install
COPY requirement.txt /app/requirement.txt
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r /app/requirement.txt

# Copy app sources
COPY . /app/

# Wait-for script
COPY ../wait-for.sh /app/wait-for.sh
RUN chmod +x /app/wait-for.sh

# Entrypoint
COPY collector_entrypoint.sh /app/collector_entrypoint.sh
RUN chmod +x /app/collector_entrypoint.sh

ENTRYPOINT ["/app/collector_entrypoint.sh"]
