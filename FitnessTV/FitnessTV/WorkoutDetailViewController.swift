
import UIKit

class WorkoutDetailViewController: UIViewController {
    
    var selectedWorkout: String?
    var selectedTime: Int?
    let client = Client()
    
    var apiKey: String {
        
        if let key = client.retrieveKeyFromPList() {
            return key.firstObject as! String
        }
        return ""
    }
    
    override func viewDidLoad() {
    
    let url = NSURL.init(string:"https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=viewCount&q=yoga%2Cback+pain%2Cexercise&relevanceLanguage=EN&safeSearch=moderate&type=video&videoCaption=any&videoDefinition=any&videoDimension=2d&videoDuration=medium&videoLicense=any&videoSyndicated=true&videoType=any&key=\(apiKey)")
    
    client.performGetRequest(url) { (data, HTTPStatusCode, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        
    
    }
    
}
