# PitStop Manager

**PitStop Manager** is a web-based Java application developed using **Eclipse IDE (Java Dynamic Web Project)**. It provides a centralized platform to manage **Formula 1 (F1) driver data**, including contracts, transfer fees, performance metrics, and market value tracking. The system is designed to help F1 team managers, sports administrators, and analysts make fast and informed decisions related to driver transfers and market dynamics.

## 🚀 Project Purpose

PitStop Manager reduces administrative overhead and improves decision-making by consolidating all essential F1 driver information in one secure, real-time accessible application.

---

## 👥 Audience

This application is intended for:
- **F1 Team Managers**
- **Sports Administrators**
- **Market Analysts**

---

## 🎯 Aim and Objectives

### Aim:
To develop a secure and centralized application that efficiently manages all aspects of F1 driver data.

### Objectives:
- Manage F1 drivers and contracts in one platform.
- Provide real-time market value tracking.
- Implement full **CRUD** functionality (Create, Read, Update, Delete) for both drivers and contracts.
- Support **secure, role-based access control** for users (admin vs general users).

---

## ✨ Features

- 🔐 **Secure User Authentication**  
  Users can register and log in securely. The system supports role-based access (admin and user).

- 👤 **Driver Management**  
  Add, view, update, and delete driver records easily through the user interface.

- 📄 **Contract Management**  
  Create and manage contracts with fields such as contract duration and transfer fees.

- 📊 **Real-Time Market Value Dashboard**  
  Dynamic interface to track the market value of drivers in real time.

- 🔍 **Driver Search**  
  Quickly search drivers by name for faster access.

- 📱 **Responsive Design**  
  Fully responsive UI using **CSS media queries** and **Flexbox**—works seamlessly on desktops, tablets, and phones without extra frameworks.

- 🔁 **Real-Time Data Sync**  
  Any data changes (like adding or editing drivers/contracts) are instantly visible to all users.

---

## 🛠️ Technologies Used

- **Java (JSP/Servlets)**
- **Eclipse IDE (Java EE / Dynamic Web Project)**
- **HTML5, CSS3 (with Flexbox and Media Queries)**
- **JavaScript (for interactivity, if used)**
- **MySQL** (or your chosen database)
- **Apache Tomcat** (as the web server)

---

## 📁 Project Structure
---

## 🔐 User Roles

- **Admin:** Full access to all CRUD functionalities and dashboards.
- **User:** Can view drivers and market value, but with limited access to admin controls.

---

## 🏁 How to Run

1. Clone or download the repository.
2. Import it into **Eclipse IDE** as a **Dynamic Web Project**.
3. Set up your database (MySQL or equivalent) and update DB connection settings in the DAO/config files.
4. Deploy the project using **Apache Tomcat**.
5. Access the app via: `http://localhost:8080/PitStopManager/`

---

## ✅ Future Improvements

- Add analytics and performance charts for drivers.
- Email notifications for expiring contracts.
- API integration for live F1 stats.

---

## 📄 License

This project is for academic and learning purposes. Feel free to fork and build upon it with proper attribution.

---

## 🙌 Acknowledgments

Special thanks to mentors, peers, and the F1 community for inspiration and guidance in the development of this project.

---
