# Event Board Project

Цей проєкт - веб-додаток для реєстрації студентів на заходи.
Написаний на класичному стеку Java EE (Servlets, JSP, JDBC) без використання складних фреймворків (завдання для 1-го курсу).

## Технічний стек
* Java 21
* Apache Tomcat 10+
* PostgreSQL
* JDBC, JSP, Servlets
* Патерн MVC та шарова архітектура (Controller, Service, Repository)
* Захист від SQL Injections (PreparedStatement) та PRG Pattern.

## Як запустити проєкт
1. Встановіть PostgreSQL та створіть базу даних `event_board`.
2. Виконайте SQL-скрипт для створення таблиць:
   ```sql
   CREATE TABLE events (
       id SERIAL PRIMARY KEY,
       title VARCHAR(255) NOT NULL,
       event_date DATE NOT NULL,
       max_seats INT NOT NULL
   );

   CREATE TABLE participants (
       id SERIAL PRIMARY KEY,
       event_id INT REFERENCES events(id),
       student_name VARCHAR(255) NOT NULL,
       student_email VARCHAR(255) NOT NULL
   );
3. Відкрийте файл src/main/java/repository/Database.java та змініть пароль на свій.
4. Відкрийте проєкт в IntelliJ IDEA, налаштуйте Tomcat Server (Local).
5. Запустіть проєкт. Головна сторінка буде доступна за адресою: http://localhost:8080/events