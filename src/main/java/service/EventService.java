package service;

import model.Event;
import model.Participant;
import repository.EventRepo;
import repository.ParticipantRepo;

public class EventService {

    private EventRepo eventRepo = new EventRepo();
    private ParticipantRepo partRepo = new ParticipantRepo();

    public boolean registerStudent(int eventId, String name, String email) {

        Event event = eventRepo.getById(eventId);
        int currentParticipants = partRepo.countByEventId(eventId);

        if (currentParticipants >= event.getMaxSeats()) {
            return false;
        }

        Participant p = new Participant();
        p.setEventId(eventId);
        p.setStudentName(name);
        p.setStudentEmail(email);

        partRepo.save(p);

        return true;
    }
}