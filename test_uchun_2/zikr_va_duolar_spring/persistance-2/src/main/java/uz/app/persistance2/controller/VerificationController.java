package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.EmailService;
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

@WebServlet("/sendVerificationCode")
public class VerificationController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(VerificationController.class.getName());
    private final UserRepository userRepository = new UserRepository();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newGmail = req.getParameter("gmail");
        User currentUser = (User) req.getSession().getAttribute("user");

        if (newGmail == null || newGmail.isEmpty() || currentUser == null) {
            resp.sendRedirect("/update_users.html?error=missingFields");
            return;
        }

        if ("admin".equalsIgnoreCase(currentUser.getRole())) {
            resp.sendRedirect("/views/erroradmin.html");
            return;
        }

        Optional<User> existingUser = userRepository.findByGmail(newGmail);
        if (existingUser.isPresent()) {
            resp.sendRedirect("/update_users.html?error=exists");
        } else {
            String verificationCode = emailService.generateVerificationCode();
            emailService.sendVerificationCode(newGmail, verificationCode);
            req.getSession().setAttribute("verificationCode", verificationCode);
            req.getSession().setAttribute("newGmail", newGmail);
            resp.sendRedirect("/views/verify_user.html");
        }
    }
}