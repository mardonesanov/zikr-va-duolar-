<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Hadislar Ro'yxati</title>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #a8e063);
            color: #333;
            margin: 0;
            padding: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .container {
            max-width: 900px;
            width: 100%;
            background: #ffffff;
            padding: 4rem;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.15);
        }
        h1 {
            font-weight: 700;
            color: #4caf50;
            text-align: center;
            margin-bottom: 3rem;
            font-size: 2.8rem;
        }
        .hadis-item {
            background: #ffffff;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            position: relative;
            cursor: pointer;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }
        .hadis-item:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }
        .hadis-title {
            color: #4caf50;
            font-size: 2rem;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .hadis-title .fa {
            margin-right: 1rem;
            color: #66bb6a;
        }
        .hadis-content {
            display: none;
            margin-top: 2rem;
            font-size: 1.4rem;
            line-height: 1.8;
        }
        .actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }
        .actions a {
            text-decoration: none;
            font-size: 1.4rem;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            background: #43a047;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s, transform 0.3s;
        }
        .actions a.delete {
            background: #e53935;
        }
        .actions a:hover {
            background-color: #388e3c;
            transform: scale(1.05);
        }
        .actions a.delete:hover {
            background-color: #c62828;
        }
        .add-hadis-btn {
            display: block;
            width: fit-content;
            margin: 2rem auto;
            text-align: center;
            background-color: #43a047;
            color: white;
            padding: 1rem 2rem;
            border-radius: 10px;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
        }
        .add-hadis-btn:hover {
            background-color: #388e3c;
            transform: scale(1.05);
        }
        .search-container {
            margin-bottom: 3rem;
            display: flex;
            justify-content: center;
        }
        .search-container input[type="text"] {
            width: 100%;
            max-width: 700px;
            padding: 1.2rem;
            border-radius: 50px;
            border: 2px solid #4caf50;
            font-size: 1.4rem;
            outline: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .search-container input[type="text"]:focus {
            border-color: #388e3c;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
        }
        .filter-container {
            margin: 1.5rem 0;
            text-align: center;
        }
        .filter-container select {
            padding: 0.8rem;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
        }
        .back-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 2rem;
            font-size: 1.4rem;
            padding: 1rem 2rem;
            border-radius: 10px;
            background: #ff7043;
            color: #ffffff;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
        }
        .back-btn:hover {
            background-color: #f4511e;
            transform: scale(1.05);
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
    <a href="/views/tizim.html" class="back-btn"><i class="fa fa-arrow-left"></i> Orqaga</a>
    <h1>Hadislar Ro'yxati</h1>
    <div class="search-container">
        <input type="text" id="search" placeholder="Hadis nomini qidiring..." onkeyup="filterHadislar()">
    </div>
    <div class="filter-container">
        <label for="imamFilter">Imom bo'yicha filter:</label>
        <select id="imamFilter" onchange="filterByImam()">
            <option value="all">Barchasi</option>
            <option value="Imom Buxoriy">Imom Buxoriy</option>
            <option value="Imom Muslim">Imom Muslim</option>
            <option value="Termiziy">Termiziy</option>
        </select>
    </div>
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/views/add_hadis.html" class="add-hadis-btn"><i class="fa fa-plus"></i> Yangi Hadis Qo'shish</a>
    </c:if>
    <c:forEach var="hadis" items="${hadisList}">
        <div class="hadis-item" data-imam="${hadis.imam}" onclick="toggleHadisContent(this)">
            <h3 class="hadis-title"><i class="fa fa-book-open"></i> ${hadis.title} (${hadis.imam})</h3>
            <div class="hadis-content">
                <p>${hadis.arabic}</p>
                <p>${hadis.transliteration}</p>
                <p>${hadis.translation}</p>
                <p>${hadis.text}</p>
            </div>
            <c:if test="${user != null && user.role == 'admin'}">
                <div class="actions">
                    <a href="/hadis?action=edit&id=${hadis.id}" class="edit"><i class="fa fa-edit"></i> Yangilash</a>
                    <form action="/hadis?action=deleteHadis&id=${hadis.id}" method="post" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                        <button type="submit" class="delete"><i class="fa fa-trash"></i> O'chirish</button>
                    </form>
                </div>
            </c:if>
        </div>
    </c:forEach>
    <c:if test="${empty hadisList}">
        <p>Hozircha hadislar mavjud emas. Iltimos, yangi hadis qo'shing.</p>
    </c:if>
</div>
</body>
</html>
