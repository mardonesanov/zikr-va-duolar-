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

@WebServlet("/verify")
public class VerifyController extends HttpServlet {
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String sessionCode = (String) req.getSession().getAttribute("verificationCode");
        String gmail = (String) req.getSession().getAttribute("gmail");
        String name = (String) req.getSession().getAttribute("name");

        if (sessionCode != null && sessionCode.equals(code)) {
            User user = new User();
            user.setGmail(gmail);
            user.setName(name);
            user.setPassword(code);
            user.setRole("user");
            userRepository.save(user);
            resp.sendRedirect("/views/signin.html");
        } else {
            resp.sendRedirect("/views/verify.html?error=invalid");
        }
    }
}