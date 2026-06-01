package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;
import model.Participant;
import repository.EventRepo;
import repository.ParticipantRepo;
import service.EventService;

import java.io.IOException;
import java.util.List;

// ця адреса буде ловити запити сторінки конкретного заходу
@WebServlet("/event")
public class RegistrationServlet extends HttpServlet {
    private EventRepo eventRepo;
    private ParticipantRepo partRepo;
    private EventService eventService;

    @Override
    public void init() {
        // ініціалізуємо все самі
        this.eventRepo = new EventRepo();
        this.partRepo = new ParticipantRepo();
        this.eventService = new EventService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // беремо id заходу з урл
        int id = Integer.parseInt(req.getParameter("id"));
        Event event = eventRepo.getById(id);
        List<Participant> pList = partRepo.getByEventId(id);

        // рахуємо вільні місця
        int remainingSeats = event.getMaxSeats() - pList.size();

        // передаємо дані заходу і список студентів на хтмл
        req.setAttribute("event", event);
        req.setAttribute("participants", pList);
        req.setAttribute("remainingSeats", remainingSeats); // ПЕРЕДАЄМО НА ФРОНТ

        req.getRequestDispatcher("/WEB-INF/event_detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ловимо дані з форми реєстрації
        int eventId = Integer.parseInt(req.getParameter("eventId"));
        String name = req.getParameter("studentName");
        String email = req.getParameter("studentEmail");

        // звертаємось до сервісу. success буде false, якщо місць нема
        boolean success = eventService.registerStudent(eventId, name, email);

        if (!success) {
            // МІСЦЬ НЕМАЄ: кидаємо помилку
            req.setAttribute("error", "На жаль, вільних місць більше немає!");

            // треба знову передати дані, щоб сторінка нормально відмалювалась
            Event event = eventRepo.getById(eventId);
            List<Participant> pList = partRepo.getByEventId(eventId);

            req.setAttribute("event", event);
            req.setAttribute("participants", pList);
            req.setAttribute("remainingSeats", event.getMaxSeats() - pList.size()); // ПЕРЕДАЄМО ЗАЛИШОК

            req.getRequestDispatcher("/WEB-INF/event_detail.jsp").forward(req, resp);
            return;
        }

        // PRG Pattern - робимо редірект на цю ж сторінку, щоб не було дублів при F5
        resp.sendRedirect(req.getContextPath() + "/event?id=" + eventId);
    }
}