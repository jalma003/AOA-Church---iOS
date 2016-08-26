//
//  ViewController.swift
//  AOA Church
//
//  Created by John Mark Almaraz II on 4/29/16.
//  Copyright © 2016 John Almaraz. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController
{
	@IBOutlet var webView: UIWebView!

	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func facebook_button()
	{
		let urlStr = "fb://profile/246271112179738"
		let URL = NSURL(string: urlStr)
		if UIApplication.sharedApplication().openURL(URL!) {}
		else
		{
			let urlStr = "http://facebook.com/aoachurch"
			let URL = NSURL(string: urlStr)
			let webVC = SFSafariViewController(URL: URL!)
			presentViewController(webVC, animated: true, completion: nil)
		}
	}

	@IBAction func bible_button()
	{
		var urlStr = "youversion:"
		var URL = NSURL(string: urlStr)
		if UIApplication.sharedApplication().openURL(URL!) {}
		else
		{
			urlStr = "https://itunes.apple.com/us/app/bible/id282935706?mt=8"
			URL = NSURL(string: urlStr)
			let webVC = SFSafariViewController(URL: URL!)
			presentViewController(webVC, animated: true, completion: nil)
		}
	}
	
	@IBAction func instagram_button()
	{
		let urlStr = "instagram://user?username=aoachurch"
		let URL = NSURL(string: urlStr)
		if UIApplication.sharedApplication().openURL(URL!) {}
		else
		{
			let urlStr = "http://instagram.com/aoachurch"
			let URL = NSURL(string: urlStr)
			let webVC = SFSafariViewController(URL: URL!)
			presentViewController(webVC, animated: true, completion: nil)
		}
	}
	
	@IBAction func web_button()
	{
		let urlStr = "https://aoachurch.com"
		let URL = NSURL(string: urlStr)
		let webVC = SFSafariViewController(URL: URL!)
		presentViewController(webVC, animated: true, completion: nil)
	}
	
	@IBAction func give_button()
	{
		
		let url = NSURL(string: "https://www.aoachurch.com/giving")
		UIApplication.sharedApplication().openURL(url!)
	}
	
	
	@IBAction func calendar() {
		let urlStr = "https://aoachurch.com/mobile-calendar"
		let URL = NSURL(string: urlStr)
		let webVC = SFSafariViewController(URL: URL!)
		presentViewController(webVC, animated: true, completion: nil)

	}
}

