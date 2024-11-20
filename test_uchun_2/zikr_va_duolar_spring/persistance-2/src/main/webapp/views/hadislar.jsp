<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Hadislar Ro'yxati</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 2rem;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .hadis-item {
            background: #ffffff;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
            position: relative;
        }
        .hadis-title {
            color: #4a90e2;
            font-size: 1.5rem;
            margin: 0;
        }
        .hadis-content {
            display: none;
            margin-top: 1rem;
        }
        .actions {
            margin-top: 1rem;
        }
        .actions a, .actions form button {
            text-decoration: none;
            color: #fff;
            background: #4a90e2;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .actions a.delete, .actions form button.delete {
            background: #f44336;
        }
        .add-hadis-btn {
            display: block;
            width: 200px;
            margin: 1rem auto;
            text-align: center;
            background-color: #4a90e2;
            color: white;
            padding: 1rem;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .add-hadis-btn:hover {
            background-color: #428bca;
        }
        .filter-container {
            margin: 1rem 0;
            text-align: center;
        }
        .filter-container select {
            padding: 0.5rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
        }
    </style>
    <script>
        function toggleHadisContent(element) {
            const content = element.querySelector('.hadis-content');
            content.style.display = content.style.display === 'block' ? 'none' : 'block';
        }

        function filterHadislar() {
            const filter = document.getElementById('search').value.toUpperCase();
            const items = document.querySelectorAll('.hadis-item');
            items.forEach(item => {
                const title = item.querySelector('.hadis-title').innerText;
                if (title.toUpperCase().indexOf(filter) > -1) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            });
        }

        function filterByImam() {
            const selectedImam = document.getElementById('imamFilter').value;
            const items = document.querySelectorAll('.hadis-item');
            items.forEach(item => {
                const imam = item.getAttribute('data-imam');
                if (selectedImam === 'all' || imam === selectedImam) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Hadislar Ro'yxati</h1>

    <!-- Qidiruv bo'limi -->
    <div class="search-container">
        <input type="text" id="search" placeholder="Hadis nomini qidiring..." onkeyup="filterHadislar()">
    </div>

    <!-- Filter bo'limi -->
    <div class="filter-container">
        <label for="imamFilter">Imom bo'yicha filter:</label>
        <select id="imamFilter" onchange="filterByImam()">
            <option value="all">Barchasi</option>
            <option value="Imom Buxoriy">Imom Buxoriy</option>
            <option value="Imom Muslim">Imom Muslim</option>
            <option value="Termiziy">Termiziy</option>
        </select>
    </div>

    <!-- Admin uchun Yangi Hadis Qo'shish tugmasi -->
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/views/add_hadis.html" class="add-hadis-btn">Yangi Hadis Qo'shish</a>
    </c:if>

    <!-- Hadislar ro'yxati -->
    <c:forEach var="hadis" items="${hadisList}">
        <div class="hadis-item" data-imam="${hadis.imam}" onclick="toggleHadisContent(this)">
            <h3 class="hadis-title">${hadis.title} (${hadis.imam})</h3>
            <div class="hadis-content">
                <p><strong>Arabcha:</strong> ${hadis.arabic}</p>
                <p><strong>O'qilishi:</strong> ${hadis.transliteration}</p>
                <p><strong>Tarjimasi:</strong> ${hadis.translation}</p>
                <p><strong>Matn:</strong> ${hadis.text}</p>
            </div>

            <!-- Admin uchun yangilash va o'chirish tugmalari -->
            <c:if test="${user != null && user.role == 'admin'}">
                <div class="actions">
                    <a href="/hadis?action=edit&id=${hadis.id}" class="edit">Yangilash</a>
                    <form action="/hadis?action=deleteHadis&id=${hadis.id}" method="post" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                        <button type="submit" class="delete">O'chirish</button>
                    </form>
                </div>
            </c:if>
        </div>
    </c:forEach>

    <!-- Agar hadislar ro'yxati bo'sh bo'lsa -->
    <c:if test="${empty hadisList}">
        <p>Hozircha hadislar mavjud emas. Iltimos, yangi hadis qo'shing.</p>
    </c:if>
</div>
</body>
</html>
