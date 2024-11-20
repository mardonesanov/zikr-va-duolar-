package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.DuaRepository;
import uz.app.persistance2.datasource.UserRepository;
import uz.app.persistance2.entity.Dua;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.logging.Logger;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AdminController.class.getName());
    private final DuaRepository duaRepository = new DuaRepository();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");
        if (isAdmin(currentUser)) {
            String action = req.getParameter("action");
            if (action == null) {
                action = "listDuolar";
            }
            switch (action) {
                case "addDua":
                    forwardToAddDuaPage(req, resp);
                    break;
                case "updateDua":
                    forwardToUpdateDuaPage(req, resp);
                    break;
                case "listUsers": // Foydalanuvchilarni ko‘rish
                    listUsers(req, resp);
                    break;
                case "deleteUser": // Foydalanuvchini o‘chirish
                    deleteUser(req, resp);
                    break;
                default:
                    listDuolar(req, resp);
                    break;
            }
        } else {
            resp.sendRedirect("/signin");
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserRepository userRepository = new UserRepository();
        List<User> users = userRepository.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/views/users.jsp").forward(req, resp);
    }


    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long userId = Long.parseLong(req.getParameter("id"));
        UserRepository userRepository = new UserRepository();
        userRepository.delete(userId);
        resp.sendRedirect("/admin?action=listUsers");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");
        if (!isAdmin(currentUser)) {
            resp.sendRedirect("/signin");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "listDuolar";
        }
        switch (action) {
            case "addDua":
                addDua(req, resp);
                break;
            case "updateDua":
                updateDua(req, resp);
                break;
            case "deleteDua":
                deleteDua(req, resp);
                break;
            default:
                resp.sendRedirect("/admin?action=listDuolar");
                break;
        }
    }

    private boolean isAdmin(User user) {
        if (user == null) {
            return false;
        }
        Optional<User> optionalUser = Optional.ofNullable(user);
        return optionalUser.isPresent() && "admin".equalsIgnoreCase(user.getRole());
    }

    private void forwardToAddDuaPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/add_dua.html").forward(req, resp);
    }

    private void forwardToUpdateDuaPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long duaId = Long.parseLong(req.getParameter("id"));
        Optional<Dua> dua = duaRepository.findById(duaId);
        dua.ifPresent(d -> req.setAttribute("dua", d));
        req.getRequestDispatcher("/views/update_dua.jsp").forward(req, resp);
    }

    private void listDuolar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Dua> duolar = duaRepository.findAll();
        req.setAttribute("duolar", duolar);
        req.getRequestDispatcher("/views/duolar.jsp").forward(req, resp);
    }

    private void addDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Dua dua = createDuaFromRequest(req);
        try {
            duaRepository.save(dua);
            logger.info("Dua successfully saved: " + dua);
        } catch (Exception e) {
            logger.severe("Error saving dua: " + e.getMessage());
        }
        resp.sendRedirect("/admin?action=listDuolar");
    }

    private void updateDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long duaId = Long.parseLong(req.getParameter("id"));
        Dua dua = createDuaFromRequest(req);
        dua.setId(duaId);
        try {
            duaRepository.update(dua);
            logger.info("Dua successfully updated: " + dua);
        } catch (Exception e) {
            logger.severe("Error updating dua: " + e.getMessage());
        }
        resp.sendRedirect("/admin?action=listDuolar");
    }

    private void deleteDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        try {
            duaRepository.delete(id);
            logger.info("Dua successfully deleted with id: " + id);
        } catch (Exception e) {
            logger.severe("Error deleting dua: " + e.getMessage());
        }
        resp.sendRedirect("/admin?action=listDuolar");
    }

    private Dua createDuaFromRequest(HttpServletRequest req) {
        String name = req.getParameter("name");
        String arabic = req.getParameter("arabic");
        String transliteration = req.getParameter("transliteration");
        String translation = req.getParameter("translation");

        Dua dua = new Dua();
        dua.setName(name);
        dua.setArabic(arabic);
        dua.setTransliteration(transliteration);
        dua.setTranslation(translation);
        return dua;
    }
}