# AWS EC2 SSH Access – Step-by-Step Documentation

## Overview

SSH (Secure Shell) is used to securely connect to Linux-based AWS EC2 instances remotely using a terminal.

Default SSH Port:

```bash
22
```

---

# Prerequisites

Before connecting to an EC2 instance, ensure:

* AWS account is available
* EC2 instance is running
* Public IP or Public DNS is assigned
* Security Group allows SSH access on port `22`
* `.pem` key pair is downloaded
* Terminal is available (Mac/Linux/Windows PowerShell)

---

# Step 1 — Launch EC2 Instance

Go to:

[AWS EC2 Console](https://console.aws.amazon.com/ec2/?utm_source=chatgpt.com)

## Recommended Settings

| Setting               | Value                      |
| --------------------- | -------------------------- |
| AMI                   | Amazon Linux 2023 / Ubuntu |
| Instance Type         | t2.micro                   |
| Key Pair              | Create new `.pem`          |
| Network               | Default VPC                |
| Auto Assign Public IP | Enable                     |
| Security Group        | Allow SSH                  |

---

# Step 2 — Configure Security Group

Allow inbound SSH traffic.

## Inbound Rule

| Type | Protocol | Port | Source |
| ---- | -------- | ---- | ------ |
| SSH  | TCP      | 22   | My IP  |

---

# Step 3 — Download PEM Key

Example:

```bash
server.pem
```

Move PEM file to your working directory.

Example:

```bash
Downloads/server.pem
```

---

# Step 4 — Verify Public IP

Go to EC2 instance details.

Copy:

* Public IPv4 Address
  OR
* Public DNS

Example:

```bash
54.210.10.20
```

---

# Step 5 — Open Terminal

## macOS / Linux

Open Terminal.

## Windows

Use:

* PowerShell
* Windows Terminal
* Git Bash

---

# Step 6 — Navigate to PEM File Location

Example:

```bash
cd ~/Downloads
```

Check file:

```bash
ls
```

---

# Step 7 — Update PEM Permissions

AWS requires secure permissions.

Run:

```bash
chmod 400 server.pem
```

Verify:

```bash
ls -l
```

Expected:

```bash
-r-------- server.pem
```

---

# Step 8 — Connect to EC2 via SSH

## Amazon Linux

```bash
ssh -i "server.pem" ec2-user@PUBLIC-IP
```

Example:

```bash
ssh -i "server.pem" ec2-user@54.210.10.20
```

---

## Ubuntu

```bash
ssh -i "server.pem" ubuntu@PUBLIC-IP
```

Example:

```bash
ssh -i "server.pem" ubuntu@54.210.10.20
```

---

# Default SSH Usernames

| OS           | Username |
| ------------ | -------- |
| Amazon Linux | ec2-user |
| Ubuntu       | ubuntu   |
| RHEL         | ec2-user |
| CentOS       | centos   |
| Debian       | admin    |
| SUSE         | ec2-user |

---

# First Time Connection Prompt

You may see:

```bash
The authenticity of host can't be established.
Are you sure you want to continue connecting?
```

Type:

```bash
yes
```

---

# Successful Connection

Expected output:

```bash
[ec2-user@ip-172-31-xx-xx ~]$
```

---

# Basic Verification Commands

## Check OS

```bash
cat /etc/os-release
```

---

## Check Current User

```bash
whoami
```

---

## Check IP

```bash
ip a
```

---

## Check Running Services

```bash
systemctl status sshd
```

---

# Common SSH Errors & Fixes

---

## 1. Permission Denied (publickey)

### Error

```bash
Permission denied (publickey)
```

### Fix

* Correct username
* Correct PEM file
* Proper permission

Run:

```bash
chmod 400 server.pem
```

---

## 2. Connection Timed Out

### Causes

* Security Group missing port 22
* Public IP unavailable
* Instance stopped

### Fix

Check:

* EC2 running state
* Public IP assigned
* SG inbound rules

---

## 3. Unprotected Private Key File

### Error

```bash
Permissions 0644 for 'server.pem' are too open
```

### Fix

```bash
chmod 400 server.pem
```

---

## 4. Host Key Verification Failed

### Fix

Remove old entry:

```bash
ssh-keygen -R PUBLIC-IP
```

Reconnect again.

---

# SSH Using Public DNS

Example:

```bash
ssh -i "server.pem" ec2-user@ec2-54-210-10-20.compute-1.amazonaws.com
```

---

# Exit from EC2

```bash
exit
```

---

# Copy File to EC2 Using SCP

## Upload File

```bash
scp -i "server.pem" file.txt ec2-user@PUBLIC-IP:/home/ec2-user
```

---

## Download File

```bash
scp -i "server.pem" ec2-user@PUBLIC-IP:/home/ec2-user/file.txt .
```

---

# Generate SSH Key on Linux Server

```bash
ssh-keygen
```

---

# Important Ports to Remember

| Service | Port |
| ------- | ---- |
| SSH     | 22   |
| HTTP    | 80   |
| HTTPS   | 443  |
| Jenkins | 8080 |
| RDP     | 3389 |

---

# Security Best Practices

* Never share PEM files
* Use least privilege SG rules
* Restrict SSH to My IP
* Disable root login
* Rotate keys regularly
* Use Bastion Host for production
* Use MFA on AWS account

---

# Architecture Flow

```text
Local Machine
      │
      │ SSH Port 22
      ▼
AWS Security Group
      ▼
EC2 Instance
```

---

# Quick Commands Cheat Sheet

```bash
# Change directory
cd ~/Downloads

# Change pem permissions
chmod 400 server.pem

# SSH login
ssh -i "server.pem" ec2-user@PUBLIC-IP

# Exit server
exit

# Upload file
scp -i "server.pem" file.txt ec2-user@PUBLIC-IP:/home/ec2-user

# Remove known host
ssh-keygen -R PUBLIC-IP
```
