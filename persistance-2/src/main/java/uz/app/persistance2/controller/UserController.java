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

@WebServlet("/user")
public class UserController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UserController.class.getName());
    private final UserRepository userRepository = new UserRepository();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            return;
        }

        switch (action) {
            case "signup":
                handleSignUp(req, resp);
                break;
            case "updateUserName":
                handleUpdateUserName(req, resp);
                break;
            case "updateGmail":
                handleUpdateGmail(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("updateUserName".equals(action)) {
            handleUpdateUserName(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleSignUp(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        String gmail = req.getParameter("gmail");

        Optional<User> existingUser = userRepository.findByGmail(gmail);
        if (existingUser.isPresent()) {
            resp.sendRedirect("signup.html?error=exists");
        } else {
            String code = emailService.generateVerificationCode();
            emailService.sendVerificationCode(gmail, code);
            req.getSession().setAttribute("verificationCode", code);
            req.getSession().setAttribute("gmail", gmail);
            req.getSession().setAttribute("name", name);
            resp.sendRedirect("/views/verify.html");
        }
    }

    private void handleUpdateUserName(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String newName = req.getParameter("newName");
        User currentUser = (User) req.getSession().getAttribute("user");
        String gmail = currentUser != null ? currentUser.getGmail() : null;

        if (newName == null || newName.trim().isEmpty()) {
            req.setAttribute("message", "Ism bo'sh bo'lishi mumkin emas!");
            req.getRequestDispatcher("/views/update_user_name.html").forward(req, resp);
            return;
        }

        if (currentUser == null) {
            logger.warning("Foydalanuvchi sessiyada mavjud emas.");
            resp.sendRedirect("/views/signin.html");
            return;
        }

        Optional<User> existingUser = userRepository.findByGmail(gmail);
        if (existingUser.isPresent()) {
            User user = existingUser.get();
            user.setName(newName);
            userRepository.update(user);
            logger.info("Foydalanuvchi muvaffaqiyatli yangilandi: " + user);
            req.getSession().setAttribute("user", user);
            req.getRequestDispatcher("/views/profil.jsp").forward(req, resp);
        } else {
            req.setAttribute("message", "Foydalanuvchi topilmadi!");
            req.getRequestDispatcher("/views/update_user_name.html").forward(req, resp);
        }
    }

    private void handleUpdateGmail(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String newGmail = req.getParameter("gmail");
        User currentUser = (User) req.getSession().getAttribute("user");

        if (newGmail == null || newGmail.trim().isEmpty()) {
            req.setAttribute("message", "Gmail manzili bo'sh bo'lishi mumkin emas!");
            req.getRequestDispatcher("/views/update_gmail.html").forward(req, resp);
            return;
        }

        if (currentUser == null) {
            logger.warning("Foydalanuvchi sessiyada mavjud emas.");
            resp.sendRedirect("/views/signin.html");
            return;
        }

        Optional<User> existingUser = userRepository.findByGmail(newGmail);
        if (existingUser.isPresent()) {
            req.setAttribute("message", "Ushbu Gmail manzili allaqachon mavjud!");
            req.getRequestDispatcher("/views/update_gmail.html").forward(req, resp);
        } else {
            String code = emailService.generateVerificationCode();
            emailService.sendVerificationCode(newGmail, code);
            req.getSession().setAttribute("verificationCode", code);
            req.getSession().setAttribute("newGmail", newGmail);
            resp.sendRedirect("/views/verify_gmail.html");
        }
    }
}
