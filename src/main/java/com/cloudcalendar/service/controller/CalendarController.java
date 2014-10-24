package com.cloudcalendar.service.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by a.zamkovyi on 08.10.2014.
 */

@Controller
public class CalendarController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView getPages() {
        ModelAndView model = new ModelAndView("calendar");
        return model;
    }


}
