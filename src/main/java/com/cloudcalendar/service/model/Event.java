package com.cloudcalendar.service.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.*;

@Entity
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;

    private String description;

    @JsonProperty("start")
    private Date dateBegin;

    @JsonProperty("end")
    private Date dateEnd;

    @Id
    private String id;

    private String title;

    public Event() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateBegin() {
        return new Date(dateBegin.getTime());
    }

    public void setDateBegin(Date dateBegin) {
        this.dateBegin = dateBegin;
    }

    public Date getDateEnd() {
        return new Date(dateEnd.getTime());
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
