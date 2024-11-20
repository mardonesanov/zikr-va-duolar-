<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Foydalanuvchilar Ro'yxati</title>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 2rem;
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: #ffffff;
            padding: 3rem;
            border-radius: 25px;
            box-shadow: 0 12px 50px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .container:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 60px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 2.5rem;
            font-size: 3.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            animation: slideIn 0.6s ease-in-out;
        }
        @keyframes slideIn {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2.5rem;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.8s ease-in-out;
        }
        table thead th {
            background-color: #007bff;
            color: #ffffff;
            padding: 1.5rem;
            text-align: left;
            font-size: 1.5rem;
            text-transform: uppercase;
        }
        table tbody td {
            padding: 1.5rem;
            border-bottom: 1px solid #ddd;
            font-size: 1.3rem;
            animation: fadeIn 1s ease-in-out;
        }
        table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tbody tr:hover {
            background-color: #e0f3ff;
            transition: background-color 0.3s ease;
        }
        .back-button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: fit-content;
            margin: 2.5rem auto 0;
            padding: 1rem 2.5rem;
            background: #007bff;
            color: #ffffff;
            font-size: 1.6rem;
            text-align: center;
            text-decoration: none;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
            transition: background 0.3s, box-shadow 0.3s;
            animation: fadeIn 1.2s ease-in-out;
        }
        .back-button:hover {
            background: #0056b3;
            box-shadow: 0 8px 25px rgba(0, 123, 255, 0.6);
        }
        .delete-button {
            color: #f44336;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s ease, transform 0.3s ease;
        }
        .delete-button:hover {
            color: #c0392b;
            transform: scale(1.1);
        }
        .action-icons {
            display: flex;
            gap: 1.5rem;
            animation: fadeIn 1.4s ease-in-out;
        }
        .action-icons a {
            color: #007bff;
            font-size: 1.8rem;
            transition: color 0.3s ease, transform 0.3s ease;
            animation: iconWiggle 1.5s;
        }
        @keyframes iconWiggle {
            0%, 100% {
                transform: rotate(0deg);
            }
            25% {
                transform: rotate(5deg);
            }
            50% {
                transform: rotate(-5deg);
            }
            75% {
                transform: rotate(5deg);
            }
        }
        .action-icons a:hover {
            color: #0056b3;
            transform: scale(1.1);
        }
        .action-icons i {
            transition: transform 0.3s ease;
        }
        .action-icons a:hover i {
            transform: rotate(10deg);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Foydalanuvchilar Ro'yxati</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Ism</th>
            <th>Gmail</th>
            <th>Rol</th>
            <th>Amallar</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <c:if test="${user.role ne 'admin'}">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.gmail}</td>
                    <td>${user.role}</td>
                    <td>
                        <div class="action-icons">
                            <a href="/admin?action=deleteUser&id=${user.id}" onclick="return confirm('Ushbu foydalanuvchini o‘chirishga ishonchingiz komilmi?');" class="delete-button" title="O'chirish"><i class="fa-solid fa-trash"></i></a>
                        </div>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    <a href="/views/sozlamalar.jsp" class="back-button"><i class="fa-solid fa-arrow-left"></i> Orqaga qaytish</a>
</div>
</body>
</html>
