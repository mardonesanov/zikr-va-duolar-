<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <title>Duolar Ro'yxati</title>
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
        .dua-item {
            background: #ffffff;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
            position: relative;
        }
        .dua-title {
            color: #4CAF50;
            font-size: 1.5rem;
            margin: 0;
        }
        .dua-content {
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
            console.log(button.dataset);
            const duaId = button.dataset.duaId;
            // Retrieve duaId from data attribute using dataset
            const isSaved = button.dataset.saved === 'true';
            console.log(`Toggle save for  Dua ID: `+duaId+`, Currently Saved: `+isSaved);
            // Debug log

            fetch(`/saveDua`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `id=`+duaId+`&saved=`+(!isSaved)
            })
                .then(response => {
                    if (response.ok) {
                        button.dataset.saved = (!isSaved).toString();
                        button.textContent = isSaved ? 'Savatga qoshish' : 'Saqlanganlardan ochirish';
                    } else {
                        alert('Saqlashda xatolik yuz berdi.');
                    }
                })
                .catch(error => {
                    console.error('Server bilan aloqa qilishda xatolik:', error);
                    alert('Server bilan aloqa qilishda xatolik.');
                });
        }

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
    <h1>Duolar Ro'yxati</h1>
    <!-- Qidiruv bo'limi -->
    <div class="search-container">
        <input type="text" id="search" placeholder="Duo nomini qidiring..." onkeyup="filterDuolar()">
    </div>
    <!-- Admin uchun Yangi Duo Qo'shish tugmasi -->
    <c:if test="${user != null && user.role == 'admin'}">
        <a href="/admin?action=addDua" class="add-dua-btn">Yangi Duo Qo'shish</a>
    </c:if>
    <!-- Duolar ro'yxati -->
    <c:forEach var="dua" items="${duolar}">
        <div class="dua-item" onclick="toggleDuaContent(this)">
            <h3 class="dua-title">${dua.name}</h3>
            <div class="dua-content">
                <p><strong>Arabcha:</strong> ${dua.arabic}</p>
                <p><strong>O'qilishi:</strong> ${dua.transliteration}</p>
                <p><strong>Tarjimasi:</strong> ${dua.translation}</p>
                <!-- Admin uchun yangilash va o'chirish tugmalari -->
                <c:if test="${user != null && user.role == 'admin'}">
                    <div class="actions">
                        <a href="/admin?action=updateDua&id=${dua.id}">Yangilash</a>
                        <form action="/admin?action=deleteDua&id=${dua.id}" method="post" style="display:inline;" onsubmit="return confirm('Haqiqatan o‘chirmoqchimisiz?');">
                            <button type="submit" class="delete">O'chirish</button>
                        </form>
                    </div>
                </c:if>
            </div>
            <div></div>
            <button class="save-btn"
                    data-dua-id="${dua.id}"
                    data-saved="${savedDuas.contains(dua.id) ? 'true' : 'false'}"
                    onclick="event.stopPropagation(); toggleSave(this);">
                    ${savedDuas.contains(dua.id) ? 'Saqlanganlardan ochirish' : 'saqlanganlarga qoshish'}
            </button>
<%--            <button class="save-btn" data-dua-id="${dua.id}" data-saved="${savedDuas.contains(dua.id) ? 'true' : 'false'}" onclick="event.stopPropagation(); toggleSave(this);">--%>
<%--                    ${savedDuas.contains(dua.id) ? 'Saqlanganlardan ochirish' : 'saqlanganlarga qoshish'}--%>
<%--            </button>--%>
        </div>
    </c:forEach>
    <c:if test="${empty duolar}">
        <p>Hozircha duolar mavjud emas. Iltimos, yangi duo qo'shing.</p>
    </c:if>
</div>
</body>
</html>
