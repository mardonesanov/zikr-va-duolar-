<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <title>Zikr va Duolar</title>
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(to right, #6BCB77, #B8E994);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            overflow: hidden;
            transition: background-color 0.5s, color 0.5s;
            user-select: none;
        }
        header {
            background: linear-gradient(90deg, #4CAF50, #81C784);
            width: 100%;
            padding: 1.5rem;
            text-align: center;
            color: white;
            font-size: 3rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            animation: slideDown 1s ease-in-out;
        }
        main {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            gap: 2rem;
            padding: 2rem;
        }
        .button-container {
            text-align: center;
            padding: 2rem;
            border-radius: 15px;
            background: linear-gradient(135deg, #ffffff, #e8f5e9);
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.5s, box-shadow 0.5s;
            animation: fadeIn 1.5s ease-in-out;
            width: 200px;
            cursor: pointer;
        }
        .button-container:hover {
            transform: scale(1.05);
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.3);
        }
        .button-container h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        .button-container i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        button {
            background: #4CAF50;
            color: white;
            padding: 1rem;
            font-size: 1.5rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        button:hover {
            background-color: #388E3C;
            transform: translateY(-5px);
        }
        @keyframes slideDown {
            0% {
                transform: translateY(-100%);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<header>
    Zikr va Duolar
</header>
<main>
    <div class="button-container" onclick="window.location.href='/views/signin.html'">
        <h2>Sign In</h2>
        <i class="fas fa-sign-in-alt"></i>
    </div>
    <div class="button-container" onclick="window.location.href='/views/signup.html'">
        <h2>Sign Up</h2>
        <i class="fas fa-user-plus"></i>
    </div>
</main>
</body>
</html>
