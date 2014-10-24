package com.cloudcalendar.service.dao;

import com.cloudcalendar.service.model.Event;

import java.util.Date;
import java.util.List;

public interface DataStore {
    void add(Event event);
    void remove(String id);
    List<Event> searchByInterval(Date leftDate, Date rightDate);
}
