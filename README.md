# AWS Windows EC2 IIS Web Hosting – Complete Hands-on Documentation

# Objective

In this lab, you will learn:

* Understanding Cloud Computing
* Benefits of Cloud Computing
* Introduction to AWS
* AWS Use Cases
* AWS Management Console
* AWS Regions
* Create a Windows EC2 Instance
* Connect to Windows Server using RDP
* Install IIS Web Server
* Host a Website on Windows Server
* Access Website using Public IP

---

# 1. Understanding Cloud Computing

## What is Cloud Computing?

Cloud Computing is the delivery of computing services such as:

* Servers
* Storage
* Databases
* Networking
* Security
* Applications

over the internet on a pay-as-you-go basis.

Instead of purchasing physical hardware, users can rent resources from cloud providers.

---

# Traditional IT vs Cloud Computing

| Traditional IT       | Cloud Computing           |
| -------------------- | ------------------------- |
| Physical Servers     | Virtual Servers           |
| High CAPEX           | Pay-as-you-go             |
| Manual Scaling       | Auto Scaling              |
| Hardware Maintenance | Managed by Cloud Provider |
| Limited Flexibility  | Highly Flexible           |

---

# Benefits of Cloud Computing

| Benefit           | Description                |
| ----------------- | -------------------------- |
| Cost Saving       | No upfront hardware cost   |
| Scalability       | Scale resources anytime    |
| High Availability | Better uptime              |
| Global Access     | Access from anywhere       |
| Security          | Advanced security features |
| Backup & Recovery | Easy disaster recovery     |
| Faster Deployment | Deploy in minutes          |

---

# 2. Overview of AWS

## What is AWS?

Amazon Web Services is a cloud computing platform provided by Amazon.

AWS provides:

* Compute
* Storage
* Networking
* Databases
* Security
* DevOps Services
* AI/ML Services

---

# Common AWS Services

| Service    | Purpose                      |
| ---------- | ---------------------------- |
| EC2        | Virtual Machines             |
| S3         | Object Storage               |
| IAM        | Identity & Access Management |
| VPC        | Virtual Networking           |
| RDS        | Managed Databases            |
| CloudWatch | Monitoring                   |
| Route53    | DNS Service                  |

---

# AWS Use Cases

| Use Case            | Example                    |
| ------------------- | -------------------------- |
| Website Hosting     | Static & Dynamic Websites  |
| Application Hosting | Enterprise Apps            |
| Backup Solutions    | Disaster Recovery          |
| DevOps              | CI/CD Pipelines            |
| AI/ML               | Machine Learning           |
| Big Data            | Analytics                  |
| Gaming              | Multiplayer Infrastructure |

---

# 3. Introduction to AWS Management Console

## AWS Console

The AWS Console is a web-based graphical interface used to manage AWS services.

Open:

[AWS Management Console](https://aws.amazon.com/console/?utm_source=chatgpt.com)

---

# AWS Console Features

| Feature         | Description          |
| --------------- | -------------------- |
| Dashboard       | Overview of services |
| Search Bar      | Search AWS services  |
| Region Selector | Change AWS region    |
| Billing         | Cost management      |
| CloudShell      | Browser terminal     |

---

# 4. Understanding AWS Regions

## What is a Region?

A Region is a geographical area where AWS data centers are located.

Example Regions:

| Region Name           | Code       |
| --------------------- | ---------- |
| US East (N. Virginia) | us-east-1  |
| Asia Pacific (Mumbai) | ap-south-1 |
| Europe (Ireland)      | eu-west-1  |

---

# What is an Availability Zone?

Availability Zones (AZs) are isolated data centers inside a region.

Example:

```text id="v6ll6j"
Mumbai Region (ap-south-1)
 ├── ap-south-1a
 ├── ap-south-1b
 └── ap-south-1c
```

---

# Benefits of Regions

* Low latency
* High availability
* Disaster recovery
* Compliance requirements

---

# 5. Steps to Create a Windows EC2 Instance

## Step 1 – Login to AWS Console

Open:

[AWS Console Login](https://console.aws.amazon.com/?utm_source=chatgpt.com)

---

# Step 2 – Open EC2 Service

Search:

```text id="5a0t48"
EC2
```

Click:

```text id="odthc9"
Launch Instance
```

---

# Step 3 – Configure Instance

## Instance Details

| Setting               | Value                         |
| --------------------- | ----------------------------- |
| Name                  | windows-server                |
| AMI                   | Microsoft Windows Server 2022 |
| Instance Type         | t2.micro                      |
| Key Pair              | Create new key pair           |
| Storage               | Default                       |
| Auto Assign Public IP | Enable                        |

---

# Step 4 – Configure Security Group

Allow:

| Type | Port |
| ---- | ---- |
| RDP  | 3389 |
| HTTP | 80   |

Source:

```text id="q1f3q6"
Anywhere (0.0.0.0/0)
```

---

# Step 5 – Launch Instance

Click:

```text id="12z5ut"
Launch Instance
```

---

# 6. Connect to Windows Instance Using Remote Desktop Connection (RDP)

## What is RDP?

RDP (Remote Desktop Protocol) is used to connect remotely to Windows machines.

Default Port:

```text id="26c22t"
3389
```

---

# Step 1 – Select EC2 Instance

Go to:

```text id="khrr6v"
EC2 → Instances
```

Select Windows instance.

---

# Step 2 – Click Connect

Choose:

```text id="2e9n0n"
RDP Client
```

---

# Step 3 – Download Remote Desktop File

Click:

```text id="jwfjlwm"
Download Remote Desktop File
```

---

# Step 4 – Get Administrator Password

Click:

```text id="n6l6f8"
Get Password
```

Upload PEM key.

Example:

```text id="8f0wq5"
server.pem
```

Click:

```text id="i4y8xb"
Decrypt Password
```

Copy password.

---

# Step 5 – Open RDP File

Open downloaded `.rdp` file.

Login credentials:

| Username | Administrator      |
| -------- | ------------------ |
| Password | Decrypted Password |

---

# Successful Login

You will see Windows Server Desktop.

---

# 7. Hosting a Website on Windows Machine (IIS Web Server)

# What is IIS?

IIS (Internet Information Services) is Microsoft’s web server used to host websites.

---

# Step 1 – Open Server Manager

Inside Windows Server:

```text id="2t4y8r"
Server Manager
```

---

# Step 2 – Add Roles and Features

Click:

```text id="vcn7m9"
Add Roles and Features
```

---

# Step 3 – Select Installation Type

Choose:

```text id="4o7kmt"
Role-based or feature-based installation
```

---

# Step 4 – Select Server

Choose local server.

Click:

```text id="mjlwm0"
Next
```

---

# Step 5 – Install Web Server (IIS)

Select:

```text id="jlwm80"
Web Server (IIS)
```

Click:

```text id="ivv51s"
Add Features
```

Then click:

```text id="utrnw0"
Install
```

---

# Step 6 – Verify IIS Installation

Open browser inside Windows Server.

Access:

```text id="w8g7eu"
http://localhost
```

Expected Output:

```text id="1yqgmb"
IIS Default Web Page
```

---

# 8. Host a Website on IIS

# Step 1 – Open IIS Website Directory

Path:

```text id="fng4l7"
C:\inetpub\wwwroot
```

---

# Step 2 – Remove Default IIS Files

Delete:

```text id="xqvkv1"
iisstart.htm
```

---

# Step 3 – Create HTML Website

Create file:

```text id="7lc7x9"
index.html
```

Example Content:

```html id="fhyc1v"
<!DOCTYPE html>
<html>
<head>
    <title>AWS IIS Website</title>
</head>
<body>
    <h1>Website Hosted on AWS Windows EC2 IIS Server</h1>
    <h2>Cloud Computing Practical</h2>
</body>
</html>
```

Save file.

---

# 9. Test Website Accessibility Using Public IP

## Step 1 – Copy Public IP

Go to EC2 instance details.

Example:

```text id="1j0x11"
13.233.120.10
```

---

# Step 2 – Access Website

Open browser on local machine:

```text id="ofx3uv"
http://PUBLIC-IP
```

Example:

```text id="q1crwi"
http://13.233.120.10
```

---

# Expected Output

```text id="p8h8rn"
Website Hosted on AWS Windows EC2 IIS Server
```

---

# Architecture Diagram

```text id="7jv4pn"
User Browser
      │
      ▼
AWS Security Group
 (HTTP Port 80)
      │
      ▼
Windows EC2 Instance
      │
      ▼
IIS Web Server
      │
      ▼
Hosted Website
```

---

# Important Ports

| Service | Port |
| ------- | ---- |
| RDP     | 3389 |
| HTTP    | 80   |
| HTTPS   | 443  |

---

# Troubleshooting

# Website Not Accessible

## Check

* EC2 instance running
* Public IP available
* Security Group allows HTTP 80
* IIS service running

---

# Restart IIS

Open PowerShell:

```powershell id="ut0kgh"
iisreset
```

---

# Check IIS Service

```powershell id="z56fsl"
Get-Service W3SVC
```

---

# Security Best Practices

* Restrict RDP access to My IP
* Use strong administrator password
* Enable HTTPS
* Keep Windows updated
* Use Security Groups properly
* Avoid opening all ports

---

# Summary

In this practical, you learned:

* Cloud Computing fundamentals
* AWS overview and services
* AWS regions and availability zones
* Creating Windows EC2 instance
* Connecting using RDP
* Installing IIS Web Server
* Hosting website on IIS
* Accessing website using public IP
