package com.cloudcalendar.service.model;

import com.google.appengine.datanucleus.annotations.Unowned;
import org.datanucleus.api.jpa.annotations.Extension;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;

    private String description;

    private Date start;

    private Date end;

    public Event(Date start, Date end, String title, String description) {
        this.description = description;
        this.start = start;
        this.end = end;
        this.title = title;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Unowned
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Attender> attenders = new HashSet<Attender>();

    public Set<Attender> getAttenders() {
        return attenders;
    }

    public void setAttenders(Set<Attender> attenders) {
        this.attenders = attenders;
    }

    protected Event() {
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
