#SERVER 3

# Use official lightweight Python 3.4-slim base image (closest to Django 1.8 timeframe)
FROM python:3.6-slim

WORKDIR /app

# Install system dependencies for psycopg2, networking tools, and Python build requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libpq-dev \
    python3-dev \
    iputils-ping \
    net-tools \
    iproute2 \
    curl \
    tcpdump \
    sqlite3 \
    postgresql-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


    
COPY requirements.txt .
COPY setup1.sh /root/
COPY setup2.sh /root/
RUN chmod +x /root/setup1.sh
RUN chmod +x /root/setup2.sh


COPY ./app .

# Install dependencies (Django and psycopg2 pinned)
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Django will run on
EXPOSE 8000

# Run Django development server (use 0.0.0.0 to allow external access)
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# migrate is needed to switch database from sqlite to postgresql
#CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"] 

# starting the server is done by the setup script, because it is needed to wait the ip configuration of the database, racing condition problem otherwise
ENTRYPOINT ["tail", "-f", "/dev/null"]
