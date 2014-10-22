package com.cloudcalendar.service.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public final class DateHelper {
    public static Date getDateFromString(final String inputStringDate, final String format) {
        SimpleDateFormat dateFormat =
                new SimpleDateFormat(format);
        Calendar calendar = Calendar.getInstance();
        try {
            calendar.setTime(dateFormat.parse(inputStringDate));
        } catch (ParseException e) {
            System.err.println("Error parsing date " + e.getMessage());
            return null;
        }

        return calendar.getTime();
    }
}
