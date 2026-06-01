package service;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class EventServiceTest {

    @Test
    void testServiceInit() {
        // Простий тест для перевірки, що об'єкт сервісу успішно створюється
        EventService service = new EventService();
        assertNotNull(service, "EventService не повинен бути null");
    }
}