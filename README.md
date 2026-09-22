# Automated CI/CD Pipeline for Flask Application on AWS EC2

An automated end-to-end Continuous Integration and Continuous Deployment (CI/CD) pipeline that deploys a Python Flask web application to an Amazon EC2 Linux instance running Nginx and Gunicorn, monitored with Amazon CloudWatch and Amazon SNS.

---

## 🏗️ Architecture Overview

1. **Source Control:** Code pushed to the GitHub repository.
2. **CI/CD Automation:** GitHub Actions workflow triggers automatically on push to the `main` branch.
3. **Deployment Target:** Connects securely over SSH to an Amazon EC2 instance (Ubuntu).
4. **Application Server:** Runs the Flask WSGI application via Gunicorn managed by `systemd`.
5. **Reverse Proxy:** Nginx routes incoming HTTP traffic on port 80 to Gunicorn on internal port 5000.
6. **Infrastructure Monitoring:** Amazon CloudWatch tracks EC2 instance status metrics and triggers Amazon SNS email alerts if checks fail.

---

## 🛠️ Tech Stack

* **Application Framework:** Python / Flask
* **WSGI Application Server:** Gunicorn
* **Web Server / Reverse Proxy:** Nginx
* **Operating System:** Ubuntu LTS (Amazon EC2)
* **CI/CD Platform:** GitHub Actions
* **Cloud & Monitoring:** Amazon Web Services (EC2, CloudWatch, SNS)

---

## 📁 Repository Structure

```text
├── app.py                      # Flask application entry point
├── requirements.txt            # Python dependencies
├── buildspec.yml               # AWS CodeBuild specifications
├── appspec.yml                 # AWS CodeDeploy lifecycle specifications
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD deployment workflow
└── scripts/
    ├── install_dependencies.sh # Environment setup & Nginx package installation
    ├── start_server.sh         # Systemd service unit & Nginx proxy configuration
    └── stop_server.sh          # Safe service teardown script


##⚙️ System & Server Configurations
1. Nginx Reverse Proxy Configuration
Configured under /etc/nginx/sites-available/flaskapp to proxy incoming HTTP traffic on port 80 to the internal Gunicorn application server:
