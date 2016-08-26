//
//  VideoModel.swift
//  AOA Church
//
//  Created by John Mark Almaraz II on 8/21/16.
//  Copyright © 2016 John Almaraz. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    let YouTube_API_KEY = "AIzaSyD-e5MLRGFjYdXPxh9HfVDL8acrZGoA3jo"
    let UPLOAD_PLAYLIST_ID = "PL3z98h0e_VHEezq32KXOXCrAjXeqBNMZl"
    
    var delegate:VideoModelDelegate?
    
    var videoArray = [Video]()
    
    func getVideos()
    {
        //Fetch videos dynamically throught the youtube data API
        Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/playlistItems", parameters: ["part":"snippet", "playlistId": UPLOAD_PLAYLIST_ID, "key":YouTube_API_KEY, "maxResults":50], encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            if let JSON = response.result.value {
                
                var arrayOfVideos = [Video]()
                
                for video in JSON["items"] as! NSArray
                {
                    
                    let videoObj = Video()
                    videoObj.videoId = video.valueForKeyPath("snippet.resourceId.videoId") as! String
                    videoObj.videoDescription = video.valueForKeyPath("snippet.description") as! String
                    videoObj.videoTitle  = video.valueForKeyPath("snippet.title") as! String
                    if video.valueForKeyPath("snippet.thumbnails.maxres.url") != nil
                    {
                        videoObj.videoThumbnailURL = video.valueForKeyPath("snippet.thumbnails.maxres.url") as! String
                    }
                    else
                    {
                        videoObj.videoThumbnailURL = video.valueForKeyPath("snippet.thumbnails.high.url") as! String
                    }
                    
                    arrayOfVideos.append(videoObj)
                    
                }
                
                //Call back and resturn the array of videos
                self.videoArray = arrayOfVideos
                
                //Notify delegate that it is finished loading videos
                if self.delegate != nil
                {
                    self.delegate!.dataReady()
                }
            }
        }
    }
}
