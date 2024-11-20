package uz.app.persistance2.controller;

import uz.app.persistance2.datasource.DuaRepository;
import uz.app.persistance2.entity.Dua;
import uz.app.persistance2.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/saveDua")
public class SavedDuaController extends HttpServlet {
    private final DuaRepository duaRepository = new DuaRepository();
    private static final Logger logger = Logger.getLogger(SavedDuaController.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            logger.warning("User not logged in, redirecting to signin page.");

            resp.sendRedirect("/signin");
            return;
        }

        Long duaId;
        boolean isSaved;

        try {
            String id = req.getParameter("id");
            String isSavedParam = req.getParameter("saved");

            if (id == null || isSavedParam == null) {
                logger.severe("Missing parameters: id or saved");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            duaId = Long.parseLong(id);
            isSaved = Boolean.parseBoolean(isSavedParam);
        } catch (Exception e) {
            logger.severe("Error parsing parameters: " + e.getMessage());
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            if (isSaved) {
                duaRepository.saveUserDua(currentUser.getId(), duaId);
                logger.info("Duo saqlandi: " + duaId + " foydalanuvchi: " + currentUser.getId());
            } else {
                duaRepository.removeUserDua(currentUser.getId(), duaId);
                logger.info("Duo o'chirildi: " + duaId + " foydalanuvchi: " + currentUser.getId());
            }
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            logger.severe("Duo saqlashda yoki o'chirishda xatolik: " + e.getMessage());
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currentUser = (User) req.getSession().getAttribute("user");

        if (currentUser == null) {
            logger.warning("Foydalanuvchi sessiyada mavjud emas, login sahifasiga yo'naltirilmoqda.");
            resp.sendRedirect("/signin");
            return;
        }

        try {
            List<Dua> savedDuas = duaRepository.findUserDuas(currentUser.getId());
            logger.info("Foydalanuvchining saqlangan duolari: " + savedDuas);

            req.setAttribute("savedDuas", savedDuas);
            req.getRequestDispatcher("/views/saqlanganlar.jsp").forward(req, resp);
        } catch (Exception e) {
            logger.severe("Xatolik yuz berdi, qayta urinib ko'ring: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Xatolik yuz berdi, qayta urinib ko'ring.");
        }
    }

}