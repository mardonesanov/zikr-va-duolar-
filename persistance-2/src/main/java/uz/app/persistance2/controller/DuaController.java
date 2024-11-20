package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.DuaRepository;
import uz.app.persistance2.entity.Dua;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
@WebServlet("/duolar")
public class DuaController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DuaController.class.getName());
    private final DuaRepository duaRepository = new DuaRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        listDuolar(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            String action = req.getParameter("action");
            if (action != null) {
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
                        resp.sendRedirect("/duolar");
                }
            }
        } else {
            resp.sendRedirect("/duolar");
        }
    }

    private void listDuolar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Dua> duolar = duaRepository.findAll();
        req.setAttribute("duolar", duolar);
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/duolar.jsp").forward(req, resp);
    }

    private void addDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Dua dua = createDuaFromRequest(req);
        duaRepository.save(dua);
        resp.sendRedirect("/duolar");
    }

    private void updateDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Dua dua = createDuaFromRequest(req);
        dua.setId(Long.parseLong(req.getParameter("id")));
        duaRepository.update(dua);
        resp.sendRedirect("/duolar");
    }

    private void deleteDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        try {
            duaRepository.delete(id);
            logger.info("Dua successfully deleted with id: " + id);
        } catch (Exception e) {
            logger.severe("Error deleting dua: " + e.getMessage());
        }
        resp.sendRedirect("/duolar");
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