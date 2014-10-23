package com.cloudcalendar.service.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;

@Entity
public class Attender implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    private String email;

    protected Attender() {
    }

    public Attender(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
