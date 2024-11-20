<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Profil</title>
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
            max-width: 600px;
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
        .profile-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            font-weight: 600;
            font-size: 1.2rem;
            background: #e9ecef;
            border-radius: 10px;
            margin-bottom: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .profile-item i {
            margin-right: 10px;
            color: #007bff;
            font-size: 1.5rem;
        }
        .profile-item span {
            margin-left: 10px;
            flex-grow: 1;
        }
        .edit-icon {
            color: #007bff;
            cursor: pointer;
            font-size: 1.4rem;
            transition: transform 0.3s ease;
        }
        .edit-icon:hover {
            transform: rotate(20deg);
        }
        .back-button {
            display: flex;
            align-items: center;
            justify-content: center;
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
        .back-button i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Profil Ma'lumotlari</h1>
    <div class="profile-item">
        <i class="fa-solid fa-user"></i>
        <span>Ism: ${user.name}</span>
        <a href="/user?action=updateUserName
" class="edit-icon" title="Ismni o'zgartirish"><i class="fa-solid fa-pen"></i></a>
    </div>

    <div class="profile-item">
        <i class="fa-solid fa-envelope"></i>
        <span>Email: ${user.gmail}</span>
        <a href="/views/update_users.html" class="edit-icon" title="Emailni o'zgartirish"><i class="fa-solid fa-pen"></i></a>
    </div>

    <a href="/views/sozlamalar.jsp" class="back-button"><i class="fa-solid fa-arrow-left"></i>Orqaga qaytish</a>
</div>
</body>
</html>
