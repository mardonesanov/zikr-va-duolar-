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

@WebServlet("/signin")
public class SigninController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(SigninController.class.getName());
    private final UserRepository userRepository = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/signin.html").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String gmail = req.getParameter("gmail");
        String password = req.getParameter("password");

        if (gmail == null || password == null || gmail.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("/signin?error=missingFields");
            return;
        }

        Optional<User> user = userRepository.findByGmail(gmail);
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            req.getSession().setAttribute("user", user.get());
            logger.info("User successfully signed in: " + user.get());
            resp.sendRedirect("/views/tizim.html");
        } else {
            resp.sendRedirect("/signin?error=invalidCredentials");
        }
    }
}