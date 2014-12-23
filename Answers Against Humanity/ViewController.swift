//
//  ViewController.swift
//  Answers Against Humanity
//
//  Created by Chris Ward on 14/12/2014.
//  Copyright (c) 2014 Gregarious Mammal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		answerLabel.text = genText()
		
	}
	
	@IBAction func genMore(sender: AnyObject) {
		answerLabel.text = genText()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBOutlet weak var answerLabel: UILabel!
	
	func genText() -> String {
		var randString: NSString = ""
		
		let filePath = NSBundle.mainBundle().pathForResource("cards",ofType:"json")
		
		var readError:NSError?
		if let data = NSData(contentsOfFile:filePath!,
			options: NSDataReadingOptions.DataReadingUncached,
			error:&readError) {
				
				let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments | NSJSONReadingOptions.MutableContainers,error:&readError)
				
				if let cardsFeed = parsedObject as? NSDictionary {
					if let cardsArray = cardsFeed["masterCards"] as? NSArray {
						let index: Int = Int(arc4random_uniform(UInt32(cardsArray.count)))
						randString = cardsArray[index]["text"] as NSString
						
					}
				}
		}
		return randString
	}
	
}

