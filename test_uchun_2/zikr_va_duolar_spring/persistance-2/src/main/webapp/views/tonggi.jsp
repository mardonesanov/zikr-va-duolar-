<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <title>Zikrlar Ro'yxati</title>
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
        .zikr-item {
            background: #ffffff;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
            position: relative;
        }
        .zikr-title {
            color: #4CAF50;
            font-size: 1.5rem;
            margin: 0;
        }
        .zikr-content {
            display: none;
            margin-top: 1rem;
        }
        .actions {
            margin-top: 1rem;
        }
        .actions a, .actions form button {
            text-decoration: none;
            color: #fff;
            background: #4CAF50;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .actions a.delete, .actions form button.delete {
            background: #f44336;
        }
    </style>
    <script>
        function toggleSave(button) {
            const zikrId = button.dataset.zikrId;
            const isSaved = button.dataset.saved === 'true';
            console.log(`Toggle save for Zikr ID: ${zikrId}, Currently Saved: ${isSaved}`);

            fetch('/saveZikr', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `id=${zikrId}&saved=${!isSaved}`
            })
                .then(response => {
                    if (response.ok) {
                        button.dataset.saved = (!isSaved).toString();
                        button.textContent = isSaved ? 'Saqlash' : 'Saqlanganlardan o‘chirish';
                    } else {
                        alert('Saqlashda xatolik yuz berdi.');
                    }
                })
                .catch(error => {
                    console.error('Server bilan aloqa qilishda xatolik:', error);
                    alert('Server bilan aloqa qilishda xatolik.');
                });
        }

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
    <h1>Zikrlar Ro'yxati</h1>
    <!-- Qidiruv bo'limi -->
    <div class="search-container">
        <input type="text" id="search" placeholder="Zikr nomini qidiring..." onkeyup="filterZikrlar()">
    </div>
    <!-- Admin uchun Yangi Zikr Qo'shish tugmasi -->
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/views/add_tongi.jsp" class="add-zikr-btn">Yangi Zikr Qo'shish</a>
    </c:if>
    <!-- Zikrlar ro'yxati -->
    <c:forEach var="zikr" items="${zikrList}">
        <div class="zikr-item" onclick="toggleZikrContent(this)">
            <h3 class="zikr-title">${zikr.name}</h3>
            <div class="zikr-content">
                <p><strong>Arabcha:</strong> ${zikr.arabic}</p>
                <p><strong>O'qilishi:</strong> ${zikr.transliteration}</p>
                <p><strong>Tarjimasi:</strong> ${zikr.translation}</p>
                <!-- Admin uchun yangilash va o'chirish tugmalari -->
                <c:if test="${user != null && user.role == 'admin'}">
                    <div class="actions">
                        <a href="/tonggi?action=edit&id=${zikr.id}">Yangilash</a>
                        <form action="/tonggi?action=deleteZikr&id=${zikr.id}" method="post" style="display:inline;" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                            <button type="submit" class="delete">O'chirish</button>
                        </form>
                    </div>
                </c:if>
            </div>
            <button class="save-btn" data-zikr-id="${zikr.id}" data-saved="${savedZikrs.contains(zikr.id) ? 'true' : 'false'}" onclick="event.stopPropagation(); toggleSave(this);">
                    ${savedZikrs.contains(zikr.id) ? 'Saqlanganlardan o‘chirish' : 'Saqlash'}
            </button>
        </div>
    </c:forEach>
    <c:if test="${empty zikrList}">
        <p>Hozircha zikrlar mavjud emas. Iltimos, yangi zikr qo'shing.</p>
    </c:if>
</div>
</body>
</html>
