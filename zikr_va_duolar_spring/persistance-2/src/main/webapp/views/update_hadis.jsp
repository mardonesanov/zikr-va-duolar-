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
    <title>Hadisni Yangilash</title>
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
            max-width: 600px;
        }
        header h1 {
            text-align: center;
            color: #4a90e2;
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
        form input, form textarea, form select {
            width: 100%;
            padding: 0.75rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        form input:focus, form textarea:focus, form select:focus {
            border-color: #4a90e2;
            outline: none;
        }
        button {
            width: 100%;
            background: #4a90e2;
            color: white;
            padding: 1rem;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #428bca;
        }
    </style>
</head>
<body>
<main>
    <header>
        <h1>Hadisni Yangilash</h1>
    </header>
    <form action="/hadis?action=updateHadis" method="post">
        <input type="hidden" name="id" value="${hadis.id}">
        <div>
            <label for="title">Hadis Nomi:</label>
            <input type="text" id="title" name="title" value="${hadis.title}" required>
        </div>
        <div>
            <label for="arabic">Arabchasi:</label>
            <textarea id="arabic" name="arabic" required>${hadis.arabic}</textarea>
        </div>
        <div>
            <label for="transliteration">O'qilishi:</label>
            <textarea id="transliteration" name="transliteration" required>${hadis.transliteration}</textarea>
        </div>
        <div>
            <label for="translation">Tarjimasi:</label>
            <textarea id="translation" name="translation" required>${hadis.translation}</textarea>
        </div>
        <div>
            <label for="text">Hadis Matni:</label>
            <textarea id="text" name="text" required>${hadis.text}</textarea>
        </div>
        <div>
            <label for="imam">Imom:</label>
            <select id="imam" name="imam" required>
                <option value="">Tanlang...</option>
                <option value="Imom Buxoriy" ${hadis.imam == 'Imom Buxoriy' ? 'selected' : ''}>Imom Buxoriy</option>
                <option value="Imom Muslim" ${hadis.imam == 'Imom Muslim' ? 'selected' : ''}>Imom Muslim</option>
                <option value="Termiziy" ${hadis.imam == 'Termiziy' ? 'selected' : ''}>Termiziy</option>
            </select>
        </div>
        <button type="submit">Yangilash</button>
    </form>
</main>
</body>
</html>
