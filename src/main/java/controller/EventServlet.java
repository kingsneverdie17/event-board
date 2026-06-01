package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Event;
import repository.EventRepo;

import java.io.IOException;
import java.time.LocalDate;

// ця штука каже томкату, що цей сервлет відповідає за адресу /events
@WebServlet("/events")
public class EventServlet extends HttpServlet {

    private EventRepo eventRepo;

    @Override
    public void init() {
        // створюємо об'єкт ручками, як просили в завданні
        this.eventRepo = new EventRepo();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // тягнемо всі заходи з бази і кладемо в атрибут, щоб jsp могла їх показати
        req.setAttribute("events", eventRepo.getAllEvents());
        // перекидаємо юзера на html-сторінку (jsp)
        req.getRequestDispatcher("/WEB-INF/events.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // ловимо дані з формочки
        String title = req.getParameter("title");
        String dateStr = req.getParameter("eventDate");
        String maxSeatsStr = req.getParameter("maxSeats");

        // пакуємо це все в об'єкт
        Event event = new Event();
        event.setTitle(title);
        event.setEventDate(LocalDate.parse(dateStr));
        event.setMaxSeats(Integer.parseInt(maxSeatsStr));

        // зберігаємо в базу
        eventRepo.createEvent(event);

        // редірект (PRG патерн), щоб при F5 форма не полетіла ще раз
        resp.sendRedirect(req.getContextPath() + "/events");
    }
}