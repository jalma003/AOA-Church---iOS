//
//  CalendarViewController.swift
//  AOA Church
//
//  Created by John Mark Almaraz II on 8/26/16.
//  Copyright © 2016 John Almaraz. All rights reserved.
//

import UIKit
import Alamofire

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventModelDelegate {
    let Google_API_KEY = "AIzaSyD-e5MLRGFjYdXPxh9HfVDL8acrZGoA3jo"
    let Calendar_ID = "o1mmovjo219tohhhmfnon3v21s@group.calendar.google.com"
    
    @IBOutlet weak var tableView: UITableView!
    
    var events:[Event] = [Event]()
    let model:EventModel = EventModel()
//    var selectedEvent:Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        self.model.fetchEvents()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        //Access the video objects that have been downloaded
        self.events = self.model.eventArray
        
        //tell table view to reload
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell")!
        
        let eventTitle = events[indexPath.row].title
        var label = cell.viewWithTag(1) as! UILabel
        label.text = eventTitle
        
        let dayStart = events[indexPath.row].startDay
        let dayEnd = events[indexPath.row].endDay
        let monStart = events[indexPath.row].startMonth
        let monEnd = events[indexPath.row].endMonth
        
        label = cell.viewWithTag(2) as! UILabel
        
        if monEnd != monStart || dayStart != dayEnd
        {
            label.text = events[indexPath.row].startDate + " - " + events[indexPath.row].endDate
        }
        else
        {
            label.text = events[indexPath.row].startDate
        }
        
        label = cell.viewWithTag(3) as! UILabel
        
        if events[indexPath.row].startTime != ""
        {
            label.text = events[indexPath.row].startTime
            
            if events[indexPath.row].endTime != ""
            {
                label.text = events[indexPath.row].startTime + " - " + events[indexPath.row].endTime
            }
        }
        
//        let videotitle = videos[indexPath.row].videoTitle
//        
//        let label = cell.viewWithTag(2) as! UILabel
//        label.text = videotitle
//        
//        
//        //Contruct video thumbnail URL
//        let videoThumbnailURLString = videos[indexPath.row].videoThumbnailURL
//        
//        //Create NSURL object
//        let videoThumbnailURL = NSURL(string: videoThumbnailURLString)
//        
//        if videoThumbnailURL != nil
//        {
//            //NSURL reques object
//            let request = NSURLRequest(URL: videoThumbnailURL!)
//            
//            //Create NSURL session
//            let session = NSURLSession.sharedSession()
//            
//            //Create a datastack and pass in request
//            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    // Get a reference to the image view element of the cell
//                    let imageView = cell.viewWithTag(1) as! UIImageView
//                    
//                    // Create an image object from the data and assign it into the image view
//                    imageView.image = UIImage(data: data!)
//                })
//            })
//            dataTask.resume()
//            
//        }
        return cell
    }
    
    
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //Take note of what video the user selected
//        self.selectedEvent = self.videos[indexPath.row]
//        
//        //Call the segue
//        performSegueWithIdentifier("goToDetail", sender: self)
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get reference to the destination view controller
//        let detailViewController = segue.destinationViewController as! VideoDetailController
    
        //Set the selected video property of the selected view controller
//        detailViewController.selectedVideo = self.selectedVideo
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
