//
//  ViewController.swift
//  Answers Against Humanity
//
//  Created by Chris Ward on 14/12/2014.
//  Copyright (c) 2014 Gregarious Mammal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var answerText: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		answerText.numberOfLines = 0
		
		let filePath = NSBundle.mainBundle().pathForResource("cards",ofType:"json")
		
		var readError:NSError?
		if let data = NSData(contentsOfFile:filePath!,
			options: NSDataReadingOptions.DataReadingUncached,
			error:&readError) {
				
				let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments | NSJSONReadingOptions.MutableContainers,error:&readError)
				
				if let cardsFeed = parsedObject as? NSDictionary {
					if let cardsArray = cardsFeed["masterCards"] as? NSArray {
						Answer.sharedInstance.answers = cardsArray
					}
				}
		}
		
		answerText.text = genText()
		
	}
	
	
	@IBAction func newAnswer(sender: AnyObject) {
		answerText.text = genText()
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func genText() -> String {
		var tempArray: NSArray = Answer.sharedInstance.answers!
		let index: Int = Int(arc4random_uniform(UInt32(tempArray.count)))
		var randString: NSString = tempArray[index]["text"] as NSString
		//println(randString)
		
		return randString
	}
	
}

