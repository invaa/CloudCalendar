package com.cloudcalendar.service.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;

    private String description;

    @Temporal(TemporalType.TIMESTAMP)
    private Date start;

    @Temporal(TemporalType.TIMESTAMP)
    private Date end;

    private String color;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Attender> attenders = new HashSet<Attender>();

    public Event(Date start, Date end, String title, String description) {
        this.description = description;
        this.start = start;
        this.end = end;
        this.title = title;
    }

    protected Event() {
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Set<Attender> getAttenders() {
        return attenders;
    }

    public void setAttenders(Set<Attender> attenders) {
        this.attenders = attenders;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
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
