<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saqlangan Duolar</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .collapsible {
            cursor: pointer;
            transition: color 0.3s;
        }
        .collapsible:hover {
            color: #4caf50;
        }
        .more-text {
            font-style: italic;
            color: #666;
        }
        .categories {
            list-style-type: none;
            padding: 0;
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .categories li {
            margin: 0 15px;
        }
        .categories a {
            text-decoration: none;
            color: #4caf50;
            font-weight: 700;
            transition: color 0.3s;
        }
        .categories a:hover {
            color: #388e3c;
        }
        body {
            font-family: 'Montserrat', sans-serif;
            background: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            background: linear-gradient(135deg, #67b26f, #4caf50);
            color: #fff;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        header h1 {
            font-size: 2rem;
            margin: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        main {
            padding: 30px;
            max-width: 900px;
            margin: auto;
        }
        .duolar {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        .dua {
            background: #fff;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            animation: fadeInUp 1s ease-in-out;
            position: relative;
            overflow: hidden;
            max-height: none;
            word-wrap: break-word;
        }
        .dua:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }
        .dua h2 {
            margin-top: 0;
            color: #4caf50;
            font-weight: 700;
            cursor: pointer;
            word-wrap: break-word;
        }
        .dua p {
            margin: 15px 0;
            overflow-wrap: break-word;
            word-wrap: break-word;
            word-break: break-word;
        }
        .save-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background: none;
            border: none;
            color: #4caf50;
            font-size: 1.5rem;
            cursor: pointer;
            transition: transform 0.3s;
        }
        .save-button:hover {
            transform: scale(1.2);
        }
        .save-button i {
            transition: transform 0.5s ease;
        }
        .save-button:hover i {
            transform: rotate(360deg);
        }
        footer {
            background: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
            font-size: 0.9rem;
            animation: fadeIn 1.5s ease-in-out;
        }
        .back-button {
            display: inline-block;
            margin: 30px auto;
            padding: 12px 20px;
            background: #67b26f;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 30px;
            transition: background 0.3s, transform 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 1s ease-in-out;
        }
        .back-button:hover {
            background: #4caf50;
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }
        i.fas {
            transition: transform 0.3s;
        }
        i.fas:hover {
            transform: rotate(360deg);
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(20px); }
        }
    </style>
</head>
<body>
<header>
    <h1><i class="fas fa-book"></i> Saqlangan Duolar</h1>
</header>
<main>
    <nav>
        <ul class="categories">
            <li><a href="#" onclick="filterCategory('kechki')">Kechki Zikrlar</a></li>
            <li><a href="#" onclick="filterCategory('tongi')">Tongi Zikrlar</a></li>
            <li><a href="#" onclick="filterCategory('namoz')">Namozdagi Duolar</a></li>
            <li><a href="#" onclick="filterCategory('masjid')">Masjiddagi Duolar</a></li>
            <li><a href="#" onclick="filterCategory('hadis')">Hadislar</a></li>
        </ul>
    </nav>
    <c:choose>
        <c:when test="${not empty savedDuas}">
            <div class="duolar">
                <c:forEach var="dua" items="${savedDuas}">
                    <c:set var="selectedCategory" value="${param.category}" scope="request"/>
                    <c:if test="${selectedCategory == null || dua.category == selectedCategory}">
                        <div class="dua">
                            <h2 onclick="toggleContent(this.parentElement)"><i class="fas fa-praying-hands"></i> ${dua.name}</h2>
                            <p><strong><i class="fas fa-book-open"></i> asl-matn:</strong> ${dua.arabic}</p>
                            <p><strong><i class="fas fa-spell-check"></i> Transliteratsiya:</strong> ${dua.transliteration}</p>
                            <p><strong><i class="fas fa-quote-right"></i> Tarjima:</strong> ${dua.translation}</p>
                            <form action="/saveDua" method="post" style="display: none;" id="deleteForm-${dua.id}">
                                <input type="hidden" name="id" value="${dua.id}">
                                <input type="hidden" name="saved" value="false">
                            </form>
                            <button class="save-button" onclick="removeDua('${dua.id}');">
                                <i class="fas fa-bookmark"></i>
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p><i class="fas fa-info-circle"></i> Hozircha saqlangan duolar mavjud emas.</p>
        </c:otherwise>
    </c:choose>
    <a href="views/tizim.html" class="back-button"><i class="fas fa-arrow-left"></i> Orqaga qaytish</a>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
<script>
    function removeDua(id) {
        const duaElement = document.getElementById('deleteForm-' + id).parentElement;
        duaElement.style.transition = 'opacity 0.5s ease-out';
        duaElement.style.opacity = '0';
        setTimeout(function() {
            fetch('http://localhost:8080/saveDua', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    id: id,
                    saved: 'false'
                })
            }).then(() => {
                window.location.href = 'http://localhost:8080/saveDua';
            });

        }, 500);
    }
</script>
<script>
    function toggleContent(element) {
        const paragraphs = element.querySelectorAll('p');
        paragraphs.forEach(paragraph => {
            if (paragraph.style.display === 'none') {
                paragraph.style.display = 'block';
            } else {
                paragraph.style.display = 'none';
            }
        });
    }
</script>
<script>
    function filterCategory(category) {
        fetch(`http://localhost:8080/filter?category=${category}`)
            .then(response => response.json())
            .then(data => {
                // Update UI with filtered data (you can implement this part as needed)
                console.log(data);
            });
    }
</script>
</body>
</html>
