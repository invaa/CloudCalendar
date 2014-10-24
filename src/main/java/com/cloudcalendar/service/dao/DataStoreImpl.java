package com.cloudcalendar.service.dao;

import com.cloudcalendar.service.model.Event;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
public class DataStoreImpl implements DataStore {

    @PersistenceContext
    private EntityManager em;

    public void persist(Event event) {
        em.persist(event);
    }

    @Override
    @Transactional
    public void add(Event event) {
        persist(event);
    }

    @Override
    @Transactional
    public void remove(String id) {
        Event ea = em.find(Event.class, id);
        em.remove(ea);
    }

    @Override
    public List<Event> searchByInterval(Date leftDate, Date rightDate) {
        List<Event> result = null;

        result = em.createQuery(
                "SELECT e FROM Event e "
                        + "WHERE e.dateBegin BETWEEN :leftDate and :rightDate ")
                .setParameter("leftDate", leftDate)
                .setParameter("rightDate", rightDate)
                .getResultList();

        if (result == null) {
            result = new ArrayList<Event>();
        }

        return result;
    }

}
