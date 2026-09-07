#!/bin/bash
cd /home/ubuntu/flask-app

# Setup virtual environment
python3 -m venv venv
./venv/bin/pip install --upgrade pip
./venv/bin/pip install -r requirements.txt

# Create systemd service unit
cat <<EOF > /etc/systemd/system/flaskapp.service
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/flask-app
Environment="PATH=/home/ubuntu/flask-app/venv/bin"
ExecStart=/home/ubuntu/flask-app/venv/bin/gunicorn --workers 3 --bind 127.0.0.1:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Setup Nginx reverse proxy
cat <<EOF > /etc/nginx/sites-available/flaskapp
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

ln -sf /etc/nginx/sites-available/flaskapp /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Start services
systemctl daemon-reload
systemctl enable flaskapp
systemctl restart flaskapp
systemctl restart nginx