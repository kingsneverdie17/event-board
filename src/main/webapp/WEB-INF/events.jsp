<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Event Board</title>
    <style>
        body {
            font-family: 'Trebuchet MS', Arial, sans-serif;
            background-color: #e5e5e5;
            color: #111;
            padding: 30px;
        }
        .container {
            max-width: 850px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 3px solid #111;
            box-shadow: 8px 8px 0px #111; /* Жорстка тінь - фішка стилю */
        }
        h2 {
            text-transform: uppercase;
            border-bottom: 3px solid #111;
            padding-bottom: 10px;
            margin-top: 0;
            letter-spacing: 1px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            border: 3px solid #111;
        }
        th, td {
            border: 1px solid #111;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #111;
            color: #fff;
            text-transform: uppercase;
        }
        tr:hover { background-color: #f4f4f4; }
        .btn {
            display: inline-block;
            background: #fff;
            color: #111;
            text-decoration: none;
            padding: 8px 15px;
            border: 2px solid #111;
            font-weight: bold;
            transition: all 0.2s;
        }
        .btn:hover {
            background: #111;
            color: #fff;
        }
        .form-box {
            margin-top: 40px;
            border: 3px dashed #111;
            padding: 25px;
            background: #fafafa;
        }
        .form-box h3 { margin-top: 0; }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px;
            border: 2px solid #111;
            box-sizing: border-box;
            font-family: inherit;
            background: #fff;
        }
        input:focus { outline: none; background: #e5e5e5; }
        button[type="submit"] {
            background-color: #111;
            color: #fff;
            padding: 12px;
            border: 2px solid #111;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
        }
        button[type="submit"]:hover {
            background-color: #fff;
            color: #111;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Дошка майбутніх заходів</h2>

        <table>
            <tr>
                <th>ID</th>
                <th>Назва заходу</th>
                <th>Дата</th>
                <th>Місць</th>
                <th>Дія</th>
            </tr>
            <c:forEach var="ev" items="${events}">
                <tr>
                    <td><strong>#${ev.id}</strong></td>
                    <td>${ev.title}</td>
                    <td>${ev.eventDate}</td>
                    <td>${ev.maxSeats}</td>
                    <td>
                        <a class="btn" href="${pageContext.request.contextPath}/event?id=${ev.id}">Деталі</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div class="form-box">
            <h3>ДОДАТИ НОВИЙ ЗАХІД</h3>
            <form action="${pageContext.request.contextPath}/events" method="post">
                <label><strong>Назва:</strong></label>
                <input type="text" name="title" required placeholder="Конференція / Лекція">

                <label><strong>Дата:</strong></label>
                <input type="date" name="eventDate" required>

                <label><strong>Максимальна кількість місць:</strong></label>
                <input type="number" name="maxSeats" min="1" required placeholder="Напр.: 30">

                <button type="submit">Створити захід</button>
            </form>
        </div>
    </div>
</body>
</html>