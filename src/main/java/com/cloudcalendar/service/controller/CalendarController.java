package com.cloudcalendar.service.controller;

import com.cloudcalendar.service.model.Attender;
import com.cloudcalendar.service.model.Event;
import com.cloudcalendar.service.repository.DataRepository;
import com.cloudcalendar.service.util.DateHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class CalendarController {

    @Autowired
    private DataRepository dataStore;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getPages() {

        ModelAndView model = new ModelAndView("calendar");
   		return model;
	}

    @RequestMapping(value = "/getEvents", method = RequestMethod.GET)
	public @ResponseBody
	List<Event> getEvents(@RequestParam String start,
                          @RequestParam String end) {

        return dataStore.findByStartBetween(
                DateHelper.getDateFromString(start, "yyyy-MM-dd"),
                DateHelper.getDateFromString(end, "yyyy-MM-dd"));
	}

    @RequestMapping(value = "/addEvent", method = RequestMethod.GET)
    public @ResponseBody
    String addEvent(@RequestParam String start,
                    @RequestParam String end,
                    @RequestParam String description,
                    @RequestParam String title,
                    @RequestParam(value="attenders[]") String[] attenders,
                    @RequestParam String color
    ) {
        String result = "{\"result\":true}";

        Event event = new Event(
            DateHelper.getDateFromString(start, "yyyy-MM-dd' 'HH:mm:ss")
            ,DateHelper.getDateFromString(end, "yyyy-MM-dd' 'HH:mm:ss")
            ,title
            ,description);

        event.setColor(color);

        Set<Attender> attendersSet = new HashSet<Attender>();
        for (String email: attenders) {
            attendersSet.add(new Attender(email));
        }
        event.setAttenders(attendersSet);

        dataStore.save(event);

        return result;
    }

//    @RequestMapping(value = "/updateEventOnDrop", method = RequestMethod.GET)
//    public @ResponseBody
//    String updateEventOnDrop(@RequestParam String id, @RequestParam @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss") Date start) throws RemoteException {
//        String result = "{\"result\":true}";
//
//        Event oldEvent = calendarService.getById(UUID.fromString(id));
//        long offset = oldEvent.getDateBegin().getTime() - start.getTime();
//
//        Event event;
//        try {
//            event = new Event.HashSetBuilder(oldEvent)
//                    .setDateBegin(new Date(oldEvent.getDateBegin().getTime() - offset))
//                    .setDateEnd(new Date(oldEvent.getDateEnd().getTime() - offset))
//                    .build();
//        } catch (IdIsNullException e) {
//            result = "{\"result\":false}";
//            e.printStackTrace();
//            return result;
//
//        } catch (DateIntervalIsIncorrectException e) {
//            result = "{\"result\":false}";
//            e.printStackTrace();
//            return result;
//        }
//
//        calendarService.remove(UUID.fromString(id));
//        calendarService.add(event);
//
//        return result;
//    }
}
