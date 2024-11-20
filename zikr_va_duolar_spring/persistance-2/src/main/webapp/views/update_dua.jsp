<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Duoni Yangilash</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        main {
            background: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        header h1 {
            text-align: center;
            color: #4CAF50;
            font-weight: 600;
            margin-bottom: 2rem;
        }
        form div {
            margin-bottom: 1.5rem;
        }
        form label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        form input, form textarea {
            width: 100%;
            padding: 0.75rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        form input:focus, form textarea:focus {
            border-color: #4CAF50;
            outline: none;
        }
        button {
            width: 100%;
            background: #4CAF50;
            color: white;
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
<main>
    <header>
        <h1>Duoni Yangilash</h1>
    </header>

    <form action="/admin?action=updateDua" method="post">
        <input type="hidden" name="id" value="${dua.id}">
        <div>
            <label for="name">Duo Nomi:</label>
            <input type="text" id="name" name="name" value="${dua.name}" required>
        </div>
        <div>
            <label for="arabic">Arabchasi:</label>
            <textarea id="arabic" name="arabic" required>${dua.arabic}</textarea>
        </div>
        <div>
            <label for="transliteration">O'qilishi:</label>
            <textarea id="transliteration" name="transliteration" required>${dua.transliteration}</textarea>
        </div>
        <div>
            <label for="translation">Tarjimasi:</label>
            <textarea id="translation" name="translation" required>${dua.translation}</textarea>
        </div>
        <button type="submit">Yangilash</button>
    </form>
</main>
</body>
</html>
