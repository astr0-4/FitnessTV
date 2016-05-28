
import UIKit

class Client: NSObject {
    
    func retrieveKeyFromPList() -> NSArray? {
        let pathOfPlist = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
        if let path = pathOfPlist {
            do {
                return try NSArray.init(contentsOfFile: path)
            }
            catch {
               print("no path!")
            }
        }
        return nil
    }
    
    func performGetRequest(targetURL: NSURL!, completion: (data: NSData?, HTTPStatusCode: Int, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: targetURL)
        request.HTTPMethod = "GET"
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            dispatch_async(dispatch_get_main_queue(), {
                var statusCode = 0
                if let responseValue : NSHTTPURLResponse = response as? NSHTTPURLResponse {
                    statusCode = responseValue.statusCode
                }
                completion(data: data, HTTPStatusCode: statusCode, error: error)
            })
        }
        
        task.resume()
    }
    
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
//            NSURLSession.dataTaskWithRequest(request, completionHandler:)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
