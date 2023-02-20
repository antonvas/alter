#!/usr/bin/env bash

echo 'Loading...'

gunicorn --reload --log-level debug --bind 0.0.0.0:80 --timeout 120  --pythonpath '/app' main:app --workers 1 --worker-class eventlet