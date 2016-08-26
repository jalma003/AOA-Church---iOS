//
//  YoutubeViewController.swift
//  AOA Church
//
//  Created by John Mark Almaraz II on 8/21/16.
//  Copyright © 2016 John Almaraz. All rights reserved.
//

import UIKit

class YoutubeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VideoModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var videos:[Video] = [Video]()
    let model:VideoModel = VideoModel()
    var selectedVideo:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.model.delegate = self
        self.model.getVideos()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady() {
        //Access the video objects that have been downloaded
        self.videos = self.model.videoArray
        
        //tell table view to reload
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.frame.size.width / 1920) * 1080
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell")!
        
        let videotitle = videos[indexPath.row].videoTitle
            
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videotitle
        
        
        //Contruct video thumbnail URL
        let videoThumbnailURLString = videos[indexPath.row].videoThumbnailURL
        
        //Create NSURL object
        let videoThumbnailURL = NSURL(string: videoThumbnailURLString)
        
        if videoThumbnailURL != nil
        {
            //NSURL reques object
            let request = NSURLRequest(URL: videoThumbnailURL!)
            
            //Create NSURL session
            let session = NSURLSession.sharedSession()
            
            //Create a datastack and pass in request
            let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    // Get a reference to the image view element of the cell
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    // Create an image object from the data and assign it into the image view
                    imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()

        }
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Take note of what video the user selected
        self.selectedVideo = self.videos[indexPath.row]
        
        //Call the segue
        performSegueWithIdentifier("goToDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get reference to the destination view controller
        let detailViewController = segue.destinationViewController as! VideoDetailController
        
        //Set the selected video property of the selected view controller
        detailViewController.selectedVideo = self.selectedVideo
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
