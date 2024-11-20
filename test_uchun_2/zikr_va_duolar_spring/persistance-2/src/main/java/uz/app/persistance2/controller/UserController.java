package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.UserRepository;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;
import java.util.logging.Logger;

@WebServlet("/updateUserName")
public class UserController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UserController.class.getName());
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newName = request.getParameter("newName");
        User currentUser = (User) request.getSession().getAttribute("user");
        String gmail = currentUser != null ? currentUser.getGmail() : null;

        if (newName == null || newName.trim().isEmpty()) {
            request.setAttribute("message", "Ism bo'sh bo'lishi mumkin emas!");
            request.getRequestDispatcher("/views/update_user_name.html").forward(request, response);
            return;
        }

        if (currentUser == null) {
            logger.warning("Foydalanuvchi sessiyada mavjud emas.");
            response.sendRedirect("/views/signin.html");
            return;
        }

        Optional<User> existingUser = userRepository.findByGmail(gmail);
        if (existingUser.isPresent()) {
            User user = existingUser.get();
            user.setName(newName);
            userRepository.update(user);
            logger.info("Foydalanuvchi muvaffaqiyatli yangilandi: " + user);
            request.getSession().setAttribute("user", user);
            request.getRequestDispatcher("/views/profil.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Foydalanuvchi topilmadi!");
            request.getRequestDispatcher("/views/update_user_name.html").forward(request, response);
        }
    }
}
