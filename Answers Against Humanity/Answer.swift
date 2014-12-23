import Foundation

class Answer {
	class var sharedInstance : Answer {
		struct Singleton {
			static let instance = Answer()
		}
		return Singleton.instance
	}
	
	var answers:NSArray?
	
}