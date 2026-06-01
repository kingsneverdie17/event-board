package repository;

import model.Participant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ParticipantRepo {

    public void save(Participant participant) {
        String sql = "INSERT INTO participants (event_id, student_name, student_email) VALUES (?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, participant.getEventId());
            ps.setString(2, participant.getStudentName());
            ps.setString(3, participant.getStudentEmail());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int countByEventId(int eventId) {
        String sql = "SELECT COUNT(*) FROM participants WHERE event_id = ?";
        int count = 0;

        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}