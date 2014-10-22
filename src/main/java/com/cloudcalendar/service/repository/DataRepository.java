package com.cloudcalendar.service.repository;

import com.cloudcalendar.service.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;

public interface DataRepository extends JpaRepository<Event, Long> {

    List<Event> findByStartBetween(Date leftDate, Date rightDate);
}
