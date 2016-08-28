//
//  EventModel.swift
//  AOA Church
//
//  Created by John Mark Almaraz II on 8/26/16.
//  Copyright © 2016 John Almaraz. All rights reserved.
//

import UIKit
import Alamofire

protocol EventModelDelegate {
    func dataReady()
}

class EventModel: NSObject {
    let Google_API_KEY = "AIzaSyD-e5MLRGFjYdXPxh9HfVDL8acrZGoA3jo"
    let Calendar_ID = "o1mmovjo219tohhhmfnon3v21s@group.calendar.google.com"
    
    var delegate:EventModelDelegate?
    
    var eventArray = [Event]()
    
    
    func fetchEvents()
    {
        
        var date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var dateString = dateFormatter.stringFromDate(date)
        
//        Fetch videos dynamically throught the youtube data API
        Alamofire.request(.GET, "https://www.googleapis.com/calendar/v3/calendars/" + Calendar_ID + "/events", parameters:["timeMin":dateString, "singleEvents":"true", "orderBy":"startTime", "key":Google_API_KEY, "maxResults":40], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            if let JSON = response.result.value {
                
                var arrayOfEvents = [Event]()
                print(JSON)
                
                for event in JSON["items"] as! NSArray
                {
                    
                    let eventObj = Event()
                    eventObj.title = event.valueForKeyPath("summary") as! String
                    if event.valueForKeyPath("description") != nil
                    {
                        eventObj.desc = event.valueForKeyPath("description") as! String
                    }
                    
                    
                    
                    //Start Date
                    if event.valueForKeyPath("start.date") != nil
                    {
                        dateString = event.valueForKeyPath("start.date") as! String
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        date = dateFormatter.dateFromString(dateString)!
                        
                    }
                    else
                    {
                        dateString = event.valueForKeyPath("start.dateTime") as! String
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        date = dateFormatter.dateFromString(dateString)!
                        dateFormatter.dateFormat = "h:mm a"
                        eventObj.startTime = dateFormatter.stringFromDate(date)
                    }
                    
                    dateFormatter.dateFormat = "EEE, MMM d"
                    eventObj.startDate = dateFormatter.stringFromDate(date)
                    
                    dateFormatter.dateFormat = "MM"
                    eventObj.startMonth = dateFormatter.stringFromDate(date)
                    
                    dateFormatter.dateFormat = "dd"
                    eventObj.startDay = dateFormatter.stringFromDate(date)
                    
                    
                    //End Date
                    
                    var end_date_check = false
                    if event.valueForKeyPath("end.date") != nil
                    {
                        dateString = event.valueForKeyPath("end.date") as! String
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        date = dateFormatter.dateFromString(dateString)!
                        end_date_check = true
                    }
                    else
                    {
                        dateString = event.valueForKeyPath("end.dateTime") as! String
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        date = dateFormatter.dateFromString(dateString)!
                        dateFormatter.dateFormat = "h:mm a"
                        eventObj.endTime = dateFormatter.stringFromDate(date)
                        end_date_check = true
                    }
                    
                    if end_date_check
                    {
                        dateFormatter.dateFormat = "EEE, MMM d"
                        eventObj.endDate = dateFormatter.stringFromDate(date)
                        
                        dateFormatter.dateFormat = "MM"
                        eventObj.endMonth = dateFormatter.stringFromDate(date)
                        
                        dateFormatter.dateFormat = "dd"
                        eventObj.endDay = dateFormatter.stringFromDate(date)
                    }
                    
                    if event.valueForKeyPath("location") != nil
                    {
                        eventObj.location = event.valueForKeyPath("location") as! String
                    }
                    
                    arrayOfEvents.append(eventObj)
                    
                }
                
//                Call back and resturn the array of videos
                self.eventArray = arrayOfEvents
                
                //Notify delegate that it is finished loading videos
                if self.delegate != nil
                {
                    self.delegate!.dataReady()
                }
            }
        }
    }

}
