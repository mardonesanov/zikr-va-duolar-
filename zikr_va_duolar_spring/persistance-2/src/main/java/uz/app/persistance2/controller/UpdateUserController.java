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

@WebServlet("/updateUser")
public class UpdateUserController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UpdateUserController.class.getName());
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");

        if (currentUser == null) {
            resp.sendRedirect("/signin");
            return;
        }

        String newGmail = req.getParameter("gmail");
        String newPassword = req.getParameter("password");

        if (newGmail == null || newPassword == null || newGmail.isEmpty() || newPassword.isEmpty()) {
            resp.sendRedirect("/views/update_users.html?error=missingFields");
            return;
        }

        try {
            Optional<User> existingUser = userRepository.findByGmail(newGmail);
            if (existingUser.isPresent() && !existingUser.get().getId().equals(currentUser.getId())) {
                resp.sendRedirect("/views/update_users.html?error=gmailExists");
                return;
            }

            currentUser.setGmail(newGmail);
            currentUser.setPassword(newPassword);
            userRepository.update(currentUser);
            logger.info("User information successfully updated: " + currentUser);
            req.getSession().setAttribute("user", currentUser);
            resp.sendRedirect("/views/sozlamalar.jsp");
        } catch (Exception e) {
            logger.severe("Error updating user information: " + e.getMessage());
            resp.sendRedirect("/views/update_users.html?error=updateFailed");
        }
    }
}
