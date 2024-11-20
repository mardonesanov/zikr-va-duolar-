package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.NamazDuaRepository;
import uz.app.persistance2.entity.NamazDua;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/namaz")
public class NamazDuaController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(NamazDuaController.class.getName());
    private final NamazDuaRepository duaRepository = new NamazDuaRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            getDuaForEdit(req, resp);
        } else {
            listDuas(req, resp);
        }
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
                        resp.sendRedirect("/namaz");
                }
            }
        } else {
            resp.sendRedirect("/namaz");
        }
    }

    private void listDuas(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<NamazDua> duaList = duaRepository.findAll();
        req.setAttribute("duaList", duaList);
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/namaz.jsp").forward(req, resp);
    }

    private void getDuaForEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            NamazDua dua = duaRepository.findById(id).orElse(null);
            if (dua == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Dua not found");
                return;
            }
            req.setAttribute("dua", dua);
            req.getRequestDispatcher("/views/update_namaz.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void addDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        NamazDua dua = createDuaFromRequest(req);
        duaRepository.save(dua);
        resp.sendRedirect("/namaz");
    }

    private void updateDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            NamazDua dua = createDuaFromRequest(req);
            dua.setId(id);
            duaRepository.update(dua);
            resp.sendRedirect("/namaz");
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void deleteDua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            duaRepository.delete(id);
            logger.info("Dua successfully deleted with id: " + id);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            logger.severe("Error deleting dua: " + e.getMessage());
        }
        resp.sendRedirect("/namaz");
    }

    private NamazDua createDuaFromRequest(HttpServletRequest req) {
        String name = req.getParameter("name");
        String arabic = req.getParameter("arabic");
        String transliteration = req.getParameter("transliteration");
        String translation = req.getParameter("translation");

        NamazDua dua = new NamazDua();
        dua.setName(name);
        dua.setArabic(arabic);
        dua.setTransliteration(transliteration);
        dua.setTranslation(translation);
        return dua;
    }
}
