<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Event Board - Головна</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 80%; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .form-box { border: 1px solid #ccc; padding: 15px; width: 300px; background: #f9f9f9; }
    </style>
</head>
<body>
    <h2>Майбутні заходи</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Назва заходу</th>
            <th>Дата</th>
            <th>Усього місць</th>
            <th>Дія</th>
        </tr>
        <c:forEach var="ev" items="${events}">
            <tr>
                <td>${ev.id}</td>
                <td>${ev.title}</td>
                <td>${ev.eventDate}</td>
                <td>${ev.maxSeats}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/event?id=${ev.id}">Реєстрація / Деталі</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <div class="form-box">
        <h3>Додати новий захід</h3>
        <form action="${pageContext.request.contextPath}/events" method="post">
            <p>Назва: <input type="text" name="title" required></p>
            <p>Дата: <input type="date" name="eventDate" required></p>
            <p>Макс. місць: <input type="number" name="maxSeats" required></p>
            <button type="submit">Створити</button>
        </form>
    </div>
</body>
</html>