<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Sozlamalar</title>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 2rem;
            transition: background-color 0.5s, color 0.5s;
        }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background: #ffffff;
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            font-family: 'Montserrat', sans-serif;
            text-transform: uppercase;
        }
        .setting-option {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.5rem;
            background: #e9ecef;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.4rem;
            transition: background 0.3s, box-shadow 0.3s, transform 0.3s;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.2rem;
        }
        .setting-option i {
            margin-right: 15px;
            color: #007bff;
            font-size: 1.8rem;
            transition: transform 0.2s ease;
        }
        .setting-option:hover {
            background: #dde2e6;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }
        .setting-option:hover i {
            transform: rotate(10deg);
        }
        .region-box {
            margin-top: 2rem;
            padding: 1.5rem;
            background: #e9ecef;
            border: 2px solid #007bff;
            border-radius: 15px;
            font-size: 1.3rem;
            text-align: center;
            font-weight: 700;
            color: #007bff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: background 0.3s, transform 0.3s;
        }
        .region-box:hover {
            background: #f0f2f5;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }
        .language-option {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: center;
            margin-top: 1rem;
            padding-left: 1rem;
        }
        .language-option div {
            cursor: pointer;
            padding: 0.8rem;
            font-weight: 600;
            font-size: 1.3rem;
            transition: background 0.3s;
        }
        .language-option div:hover {
            background: #e9ecef;
            border-radius: 8px;
        }
        .setting-option span {
            flex-grow: 1;
        }
        .back-button {
            display: block;
            width: fit-content;
            margin: 2rem auto 0;
            padding: 1rem 2rem;
            background: #007bff;
            color: #ffffff;
            font-size: 1.4rem;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            border-radius: 10px;
            transition: background 0.3s;
        }
        .back-button:hover {
            background: #0056b3;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const selectedRegion = localStorage.getItem('selectedRegion');
            if (selectedRegion) {
                document.getElementById('regionBox').innerText = "Tanlangan mintaqa: " + selectedRegion;
            }

            const selectedLanguage = localStorage.getItem('selectedLanguage');
            if (selectedLanguage) {
                document.getElementById('languageLabel').innerText = "Tanlangan til: " + selectedLanguage.toUpperCase();
            }

            const theme = localStorage.getItem('theme') || 'light';
            if (theme === 'dark') {
                document.body.classList.add('dark-mode');
                document.body.style.backgroundColor = '#333';
                document.body.style.color = '#f8f9fa';
                document.getElementById('themeIcon').classList.remove('fa-sun');
                document.getElementById('themeIcon').classList.add('fa-moon');
            }
        });

        function toggleNotification() {
            const notificationIcon = document.getElementById('notificationIcon');
            if (notificationIcon.classList.contains('fa-bell')) {
                notificationIcon.classList.remove('fa-bell');
                notificationIcon.classList.add('fa-bell-slash');
                alert('Bildirishnoma o‘chirildi');
            } else {
                notificationIcon.classList.remove('fa-bell-slash');
                notificationIcon.classList.add('fa-bell');
                alert('Bildirishnoma yoqildi');
            }
        }

        function updateLanguage(language) {
            document.getElementById('languageLabel').innerText = "Tanlangan til: " + language.toUpperCase();
            localStorage.setItem('selectedLanguage', language);
            document.getElementById('languageOptions').style.display = 'none';
        }

        function toggleTheme() {
            const body = document.body;
            const themeIcon = document.getElementById('themeIcon');
            if (body.classList.contains('dark-mode')) {
                body.classList.remove('dark-mode');
                body.style.backgroundColor = '#f0f2f5';
                body.style.color = '#333';
                localStorage.setItem('theme', 'light');
                themeIcon.classList.remove('fa-moon');
                themeIcon.classList.add('fa-sun');
            } else {
                body.classList.add('dark-mode');
                body.style.backgroundColor = '#333';
                body.style.color = '#f8f9fa';
                localStorage.setItem('theme', 'dark');
                themeIcon.classList.remove('fa-sun');
                themeIcon.classList.add('fa-moon');
            }
        }
    </script>
</head>
<body>
<c:if test="${user != null && user.role == 'admin'}">
    <div class="setting-option" onclick="location.href='/admin?action=listUsers'"><i class="fa-solid fa-users"></i><span>Foydalanuvchilarni Ko'rish</span></div>
</c:if>
<div class="setting-option" onclick="location.href='/views/mintaqa.html'"><i class="fa-solid fa-location-dot"></i><span>Mintaqa Tanlash</span></div>
<div class="setting-option" onclick="location.href='/views/dastur.html'"><i class="fa-solid fa-circle-info"></i><span>Dastur Haqida</span></div>
<div class="setting-option" onclick="location.href='/views/profil.jsp'"><i class="fa-solid fa-user-circle"></i><span>Profil</span></div>
<div class="setting-option" onclick="toggleLanguageOptions()"><i class="fa-solid fa-globe"></i><span>Til Tanlash: <span id="languageLabel">Tanlangan til: UZ</span></span></div>
<div class="language-option" id="languageOptions" style="display: none;">
    <div onclick="updateLanguage('uz')">UZ</div>
    <div onclick="updateLanguage('ru')">RU</div>
    <div onclick="updateLanguage('en')">EN</div>
</div>
<div class="setting-option" onclick="toggleNotification()"><i id="notificationIcon" class="fa-solid fa-bell"></i><span>Bildirishnomalar</span></div>
<div class="setting-option" onclick="toggleTheme()"><i id="themeIcon" class="fa-solid fa-sun"></i><span>Rejim: Qorong'u / Oq</span></div>
<div class="region-box" id="regionBox">Mintaqa tanlanmagan</div>
<a href="tizim.html" class="back-button">Orqaga qaytish</a>
<script>
    function toggleLanguageOptions() {
        const languageOptions = document.getElementById('languageOptions');
        if (languageOptions.style.display === 'none') {
            languageOptions.style.display = 'block';
        } else {
            languageOptions.style.display = 'none';
        }
    }
</script>
</body>
</html>
