FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN python -m venv /opt/venv && . /opt/venv/bin/activate && pip install -r requirements.txt

COPY . .

# Create the paracord_runner.sh script
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "source /opt/venv/bin/activate\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "python manage.py collectstatic --noinput\n" >> ./paracord_runner.sh && \
    printf "gunicorn AceCoder.wsgi:application --bind 0.0.0.0:8000\n" >> ./paracord_runner.sh

# Make the script executable
RUN chmod +x ./paracord_runner.sh

# Clean up apt cache to reduce image size
RUN apt-get remove --purge -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the entry point to the paracord_runner.sh script
ENTRYPOINT ["./paracord_runner.sh"]