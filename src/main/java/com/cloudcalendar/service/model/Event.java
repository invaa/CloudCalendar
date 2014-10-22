package com.cloudcalendar.service.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.*;

@Entity
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;

    private String description;

    private Date start;

    private Date end;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    public Event() {
    }

    public String getDescription() {
        return description;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Long getId() {
        return id;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }
}
