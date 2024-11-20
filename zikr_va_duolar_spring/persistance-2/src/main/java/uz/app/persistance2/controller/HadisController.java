package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.HadisRepository;
import uz.app.persistance2.entity.Hadis;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/hadis")
public class HadisController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(HadisController.class.getName());
    private final HadisRepository hadisRepository = new HadisRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            getHadisForEdit(req, resp);
        } else {
            listHadislar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            String action = req.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "addHadis":
                        addHadis(req, resp);
                        break;
                    case "updateHadis":
                        updateHadis(req, resp);
                        break;
                    case "deleteHadis":
                        deleteHadis(req, resp);
                        break;
                    default:
                        resp.sendRedirect("/hadis");
                }
            }
        } else {
            resp.sendRedirect("/hadis");
        }
    }

    private void listHadislar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Hadis> hadisList = hadisRepository.findAll();
        logger.info("Hadislar soni: " + (hadisList != null ? hadisList.size() : "null"));
        req.setAttribute("hadisList", hadisList);
        User user = (User) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/hadislar.jsp").forward(req, resp);
    }

    private void getHadisForEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            Hadis hadis = hadisRepository.findById(id).orElse(null);
            if (hadis == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Hadis not found");
                return;
            }
            req.setAttribute("hadis", hadis);
            req.getRequestDispatcher("/views/update_hadis.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void addHadis(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Hadis hadis = createHadisFromRequest(req);
        hadisRepository.save(hadis);
        resp.sendRedirect("/hadis");
    }

    private void updateHadis(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            Hadis hadis = createHadisFromRequest(req);
            hadis.setId(Math.toIntExact(id));
            hadisRepository.update(hadis);
            resp.sendRedirect("/hadis");
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        }
    }

    private void deleteHadis(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            logger.severe("ID parameter is missing or empty");
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            return;
        }
        try {
            Long id = Long.parseLong(idParam.trim());
            hadisRepository.delete(id);
            logger.info("Hadis successfully deleted with id: " + id);
        } catch (NumberFormatException e) {
            logger.severe("Invalid ID format: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            logger.severe("Error deleting hadis: " + e.getMessage());
        }
        resp.sendRedirect("/hadis");
    }

    private Hadis createHadisFromRequest(HttpServletRequest req) {
        String title = req.getParameter("title");
        String arabic = req.getParameter("arabic");
        String transliteration = req.getParameter("transliteration");
        String translation = req.getParameter("translation");
        String text = req.getParameter("text");
        String imam = req.getParameter("imam");

        Hadis hadis = new Hadis();
        hadis.setTitle(title);
        hadis.setArabic(arabic);
        hadis.setTransliteration(transliteration);
        hadis.setTranslation(translation);
        hadis.setText(text);
        hadis.setImam(imam);
        return hadis;
    }
}
