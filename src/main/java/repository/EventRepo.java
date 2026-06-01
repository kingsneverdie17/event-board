package repository;

import model.Event;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventRepo {

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY event_date";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Event event = new Event();
                event.setId(rs.getInt("id"));
                event.setTitle(rs.getString("title"));
                event.setEventDate(rs.getDate("event_date").toLocalDate());
                event.setMaxSeats(rs.getInt("max_seats"));
                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public void createEvent(Event event) {
        String sql = "INSERT INTO events (title, event_date, max_seats) VALUES (?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getTitle());
            ps.setDate(2, Date.valueOf(event.getEventDate()));
            ps.setInt(3, event.getMaxSeats());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public Event getById(int id) {
        String sql = "SELECT * FROM events WHERE id = ?";
        Event event = null;

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    event = new Event();
                    event.setId(rs.getInt("id"));
                    event.setTitle(rs.getString("title"));
                    event.setEventDate(rs.getDate("event_date").toLocalDate());
                    event.setMaxSeats(rs.getInt("max_seats"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return event;
    }
}