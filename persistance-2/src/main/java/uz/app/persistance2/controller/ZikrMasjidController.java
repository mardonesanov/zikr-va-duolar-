package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.ZikrMasjidRepository;
import uz.app.persistance2.entity.ZikrMasjid;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/masjid")
public class ZikrMasjidController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ZikrMasjidController.class.getName());
    private final ZikrMasjidRepository zikrRepository = new ZikrMasjidRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            getZikrForEdit(req, resp);
        } else {
            listZikrs(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            String action = req.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "addZikr":
                        addZikr(req, resp);
                        break;
                    case "updateZikr":
                        updateZikr(req, resp);
                        break;
                    case "deleteZikr":
                        deleteZikr(req, resp);
                        break;
                    default:
                        resp.sendRedirect("/masjid");
                }
            }
        } else {
            resp.sendRedirect("/masjid");
        }
    }

    private void listZikrs(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ZikrMasjid> zikrList = zikrRepository.findAll();
        req.setAttribute("zikrList", zikrList);
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/zikr_masjid.jsp").forward(req, resp);
    }

    private void getZikrForEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            ZikrMasjid zikr = zikrRepository.findById(id).orElse(null);
            if (zikr == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Zikr not found");
                return;
            }
            req.setAttribute("zikr", zikr);
            req.getRequestDispatcher("/views/update_zikr_masjid.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void addZikr(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ZikrMasjid zikr = createZikrFromRequest(req);
        zikrRepository.save(zikr);
        resp.sendRedirect("/masjid");
    }

    private void updateZikr(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            ZikrMasjid zikr = createZikrFromRequest(req);
            zikr.setId(id);
            zikrRepository.update(zikr);
            resp.sendRedirect("/masjid");
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void deleteZikr(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            zikrRepository.delete(id);
            logger.info("Zikr successfully deleted with id: " + id);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            logger.severe("Error deleting zikr: " + e.getMessage());
        }
        resp.sendRedirect("/masjid");
    }

    private ZikrMasjid createZikrFromRequest(HttpServletRequest req) {
        String name = req.getParameter("name");
        String arabic = req.getParameter("arabic");
        String transliteration = req.getParameter("transliteration");
        String translation = req.getParameter("translation");

        ZikrMasjid zikr = new ZikrMasjid();
        zikr.setName(name);
        zikr.setArabic(arabic);
        zikr.setTransliteration(transliteration);
        zikr.setTranslation(translation);
        return zikr;
    }
}