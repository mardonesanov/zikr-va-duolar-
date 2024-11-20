<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Masjid Zikrlari Ro'yxati</title>
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
        .zikr-item {
            background: #ffffff;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 3rem;
            position: relative;
            cursor: pointer;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }
        .zikr-item:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }
        .zikr-title {
            color: #388E3C;
            font-size: 2rem;
            margin: 0;
            display: flex;
            align-items: center;
        }
        .zikr-content {
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
        .btn.btn-success {
            font-size: 1.6rem;
            padding: 1.2rem 2.5rem;
            border-radius: 12px;
            background-color: #388E3C;
            color: #ffffff;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn.btn-success i {
            margin-right: 0.5rem;
        }
        .btn.btn-success:hover {
            background-color: #2E7D32;
            transform: translateY(-3px);
        }
    </style>
    <script>
        function toggleZikrContent(element) {
            const content = element.querySelector('.zikr-content');
            content.style.display = content.style.display === 'block' ? 'none' : 'block';
        }

        function filterZikrlar() {
            const filter = document.getElementById('search').value.toUpperCase();
            const items = document.querySelectorAll('.zikr-item');
            items.forEach(item => {
                const title = item.querySelector('.zikr-title').innerText;
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

    <h1>Masjid Zikrlari Ro'yxati</h1>
    <div class="search-container">
        <input type="text" id="search" placeholder="Zikr nomini qidiring..." onkeyup="filterZikrlar()" class="form-control">
    </div>
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/views/add_zikr_masjid.html" class="btn btn-success mt-3"><i class="fas fa-plus-circle"></i> Yangi Zikr Qo'shish</a>
    </c:if>
    <c:forEach var="zikr" items="${zikrList}">
        <div class="zikr-item" onclick="toggleZikrContent(this)">
            <h3 class="zikr-title"><i class="fas fa-mosque"></i> ${zikr.name}</h3>
            <div class="zikr-content">
                <p>${zikr.arabic}</p>
                <p>${zikr.transliteration}</p>
                <p>${zikr.translation}</p>
                <c:if test="${user != null && user.role == 'admin'}">
                    <div class="actions">
                        <a href="/masjid?action=edit&id=${zikr.id}"><i class="fas fa-edit"></i> Yangilash</a>
                        <form action="/masjid?action=deleteZikr&id=${zikr.id}" method="post" style="display:inline;" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                            <button type="submit" class="delete"><i class="fas fa-trash-alt"></i> O'chirish</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty zikrList}">
        <p>Hozircha zikrlar mavjud emas. Iltimos, yangi zikr qo'shing.</p>
    </c:if>
</div>
</body>
</html>
