<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Деталі заходу</title>
    <style>
        body {
            font-family: 'Trebuchet MS', Arial, sans-serif;
            background-color: #e5e5e5;
            color: #111;
            padding: 30px;
        }
        .container {
            max-width: 650px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 3px solid #111;
            box-shadow: 8px 8px 0px #111;
        }
        .back-link {
            text-decoration: none;
            color: #111;
            font-weight: bold;
            border-bottom: 2px solid #111;
            display: inline-block;
            margin-bottom: 20px;
        }
        .back-link:hover { background: #111; color: #fff; }
        h2 {
            text-transform: uppercase;
            border-bottom: 3px solid #111;
            padding-bottom: 10px;
            margin-top: 0;
        }
        .info-block {
            background: #f4f4f4;
            border: 2px solid #111;
            padding: 15px;
            margin-bottom: 25px;
        }
        .info-block p { margin: 5px 0; }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border: 2px solid #111;
            font-weight: bold;
            margin-top: 10px;
        }
        .available { background: #fff; color: #111; }
        .full { background: #111; color: #fff; }

        .error {
            background: #111;
            color: #fff;
            padding: 15px;
            font-weight: bold;
            border: 2px dashed #fff;
            margin-bottom: 20px;
            text-transform: uppercase;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0 20px;
            border: 2px solid #111;
            box-sizing: border-box;
            background: #fff;
            font-family: inherit;
        }
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
        button[type="submit"]:hover { background-color: #fff; color: #111; }

        ul { list-style-type: square; padding-left: 20px; }
        li { margin-bottom: 10px; border-bottom: 1px dashed #ccc; padding-bottom: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <a class="back-link" href="${pageContext.request.contextPath}/events">← НАЗАД</a>

        <h2>${event.title}</h2>

        <div class="info-block">
            <p><strong>ДАТА:</strong> ${event.eventDate}</p>
            <p><strong>ВСЬОГО МІСЦЬ:</strong> ${event.maxSeats}</p>

            <c:choose>
                <c:when test="${remainingSeats > 0}">
                    <div class="status-badge available">ВІЛЬНИХ МІСЦЬ: ${remainingSeats}</div>
                </c:when>
                <c:otherwise>
                    <div class="status-badge full">МІСЦЬ НЕМАЄ</div>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty error}">
            <div class="error">Помилка: ${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${remainingSeats > 0}">
                <h3>РЕЄСТРАЦІЯ</h3>
                <form action="${pageContext.request.contextPath}/event" method="post">
                    <input type="hidden" name="eventId" value="${event.id}">

                    <label><strong>ПІБ студента:</strong></label>
                    <input type="text" name="studentName" required autocomplete="off">

                    <label><strong>Email:</strong></label>
                    <input type="email" name="studentEmail" required autocomplete="off">

                    <button type="submit">Записатися</button>
                </form>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; border: 2px solid #111; padding: 15px; margin: 20px 0;">
                    <strong>РЕЄСТРАЦІЮ ЗАКРИТО</strong>
                </div>
            </c:otherwise>
        </c:choose>

        <h3>УЧАСНИКИ:</h3>
        <ul>
            <c:forEach var="p" items="${participants}">
                <li><strong>${p.studentName}</strong> <em>(${p.studentEmail})</em></li>
            </c:forEach>
            <c:if test="${empty participants}">
                <p>Поки що пусто.</p>
            </c:if>
        </ul>
    </div>
</body>
</html>