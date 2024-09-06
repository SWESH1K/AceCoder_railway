#!/bin/bash
source /opt/venv/bin/activate
python manage.py migrate --no-input
python manage.py collectstatic --noinput
gunicorn AceCoder.wsgi:application --bind 0.0.0.0:8000