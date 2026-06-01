<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Деталі заходу</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; font-weight: bold; padding: 10px; border: 1px solid red; display: inline-block;}
        .container { border: 1px solid #ccc; padding: 20px; max-width: 500px; }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/events">← Назад до списку заходів</a>

    <div class="container">
        <h2>${event.title}</h2>
        <p><strong>Дата:</strong> ${event.eventDate}</p>
        <p><strong>Максимальна кількість місць:</strong> ${event.maxSeats}</p>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <hr>

        <h3>Реєстрація</h3>
        <form action="${pageContext.request.contextPath}/event" method="post">
            <input type="hidden" name="eventId" value="${event.id}">
            <p>Ім'я студента: <input type="text" name="studentName" required></p>
            <p>Email: <input type="email" name="studentEmail" required></p>
            <button type="submit">Зареєструватися</button>
        </form>

        <hr>

        <h3>Вже зареєструвалися:</h3>
        <ul>
            <c:forEach var="p" items="${participants}">
                <li>${p.studentName} (${p.studentEmail})</li>
            </c:forEach>
            <c:if test="${empty participants}">
                <p>Ще немає зареєстрованих учасників. Будь першим!</p>
            </c:if>
        </ul>
    </div>
</body>
</html>