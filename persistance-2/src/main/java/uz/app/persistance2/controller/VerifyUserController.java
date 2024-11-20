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
@WebServlet("/verifyUser")
public class VerifyUserController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(VerifyUserController.class.getName());
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String sessionCode = (String) req.getSession().getAttribute("verificationCode");
        String newGmail = (String) req.getSession().getAttribute("newGmail");
        User currentUser = (User) req.getSession().getAttribute("user");

        if (sessionCode != null && sessionCode.equals(code) && currentUser != null && newGmail != null) {
            if ("admin".equalsIgnoreCase(currentUser.getRole())) {
                resp.sendRedirect("/views/erroradmin.html");
                return;
            }
            currentUser.setGmail(newGmail);
            currentUser.setPassword(code);
            userRepository.update(currentUser);
            req.getSession().setAttribute("user", currentUser);
            resp.sendRedirect("/views/sozlamalar.jsp");
        } else {
            resp.sendRedirect("/views/verify_user.html?error=invalid");
        }
    }
}

