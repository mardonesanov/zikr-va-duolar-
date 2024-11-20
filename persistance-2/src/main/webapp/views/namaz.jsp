<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Namozdagi Duolar Ro'yxati</title>
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
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        h1 {
            font-weight: 700;
            color: #388E3C;
            text-align: center;
            margin-bottom: 3rem;
            font-size: 2.8rem;
        }
        .dua-item {
            background: #ffffff;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 3rem;
            position: relative;
            cursor: pointer;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }
        .dua-item:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }
        .dua-title {
            color: #388E3C;
            font-size: 2rem;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .dua-content {
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
            background: #0d6efd;
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s;
        }
        .actions a.delete {
            background: #f44336;
        }
        .actions a:hover {
            background-color: #0b5ed7;
        }
        .actions a.delete:hover {
            background-color: #d32f2f;
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
            border: 2px solid #388E3C;
            font-size: 1.4rem;
            outline: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .search-container input[type="text"]:focus {
            border-color: #2E7D32;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
        }
        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 1.6rem;
            padding: 1rem 2rem;
            border-radius: 12px;
            background-color: #0d6efd;
            color: #ffffff;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-back:hover {
            background-color: #0b5ed7;
            transform: translateY(-3px);
        }
        .btn-add-dua {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            padding: 1.2rem 2.5rem;
            border-radius: 12px;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: #ffffff;
            text-decoration: none;
            transition: background 0.3s, transform 0.3s;
            margin: 0 auto 3rem auto;
            max-width: 300px;
            font-weight: 600;
        }
        .btn-add-dua i {
            margin-right: 0.8rem;
            font-size: 2rem;
        }
        .btn-add-dua:hover {
            background: linear-gradient(135deg, #5bc0de, #1e88e5);
            transform: translateY(-3px);
        }
    </style>
    <script>
        function toggleDuaContent(element) {
            const content = element.querySelector('.dua-content');
            content.style.display = content.style.display === 'block' ? 'none' : 'block';
        }

        function filterDuolar() {
            const filter = document.getElementById('search').value.toUpperCase();
            const items = document.querySelectorAll('.dua-item');
            items.forEach(item => {
                const title = item.querySelector('.dua-title').innerText;
                if (title.toUpperCase().indexOf(filter) > -1) {
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
    <a href="/views/tizim.html" class="btn-back"><i class="fas fa-arrow-left"></i> Orqaga</a>

    <h1>Namozdagi Duolar Ro'yxati</h1>
    <div class="search-container">
        <input type="text" id="search" placeholder="Duo nomini qidiring..." onkeyup="filterDuolar()" class="form-control">
    </div>
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/views/add_namaz.html" class="btn-add-dua"><i class="fas fa-plus-circle"></i> Yangi Duo Qo'shish</a>
    </c:if>
    <c:forEach var="dua" items="${duaList}">
        <div class="dua-item" onclick="toggleDuaContent(this)">
            <h3 class="dua-title"><i class="fas fa-praying-hands"></i> ${dua.name}</h3>
            <div class="dua-content">
                <p>${dua.arabic}</p>
                <p>${dua.transliteration}</p>
                <p>${dua.translation}</p>
                <c:if test="${user != null && user.role == 'admin'}">
                    <div class="actions">
                        <a href="/namaz?action=edit&id=${dua.id}"><i class="fas fa-edit"></i> Yangilash</a>
                        <form action="/namaz?action=deleteDua&id=${dua.id}" method="post" style="display:inline;" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                            <button type="submit" class="delete"><i class="fas fa-trash-alt"></i> O'chirish</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty duaList}">
        <p>Hozircha duolar mavjud emas. Iltimos, yangi duo qo'shing.</p>
    </c:if>
</div>
</body>
</html>
