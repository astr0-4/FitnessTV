
import UIKit

class WorkoutDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedWorkout: String?
    var selectedTime: Int?
    let client = Client()
    var videoIds = [String]()
    var titles = [String]()
    var thumbnailURLs = [String]()
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!

    var apiKey: String {
        
        if let key = client.retrieveKeyFromPList() {
            return key.firstObject as! String
        }
        return ""
    }
    
    override func viewDidLoad() {
        
    self.thumbnailCollectionView.registerNib(UINib(nibName: "ThumbnailCell", bundle:nil), forCellWithReuseIdentifier: "ThumbnailCellReuseIdentifier")
    
    let url = NSURL.init(string:"https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=viewCount&q=yoga%2Cback+pain%2Cexercise&relevanceLanguage=EN&safeSearch=moderate&type=video&videoCaption=any&videoDefinition=any&videoDimension=2d&videoDuration=medium&videoLicense=any&videoSyndicated=true&videoType=any&key=\(apiKey)")
    
    var dataDict = [String : AnyObject]()

    client.performGetRequest(url) { (data, HTTPStatusCode, error) in
        do { dataDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! Dictionary
        } catch {
            print("could not save to data dict")
        }
        
        var ids = [AnyObject?]()
        var snippets = [AnyObject?]()
        
        guard let items : [Dictionary<String, AnyObject>] = dataDict["items"] as? Array else {
            return
        }
        
        for item in items {
            ids.append(item["id"])
            snippets.append(item["snippet"])
        }
        
        var optionalVideoIds = [AnyObject?]()
        for id in ids {
            optionalVideoIds.append(id?.objectForKey("videoId"))
        }
        var optionalTitles = [AnyObject?]()
        var optionalThumbnails = [AnyObject?]()
        for snippet in snippets {
            optionalTitles.append(snippet?.objectForKey("title"))
            optionalThumbnails.append(snippet?.objectForKey("thumbnails")?.objectForKey("high")?.objectForKey("url"))
        }
        
        self.titles = optionalTitles.flatMap { $0 as? String }
        self.thumbnailURLs = optionalThumbnails.flatMap { $0 as? String }
        self.videoIds = optionalVideoIds.flatMap { $0 as? String }
        print("videoIds : \(self.videoIds)")
        print("thumbnails: \(self.thumbnailURLs)")
        print("titles: \(self.titles)")
        self.thumbnailCollectionView.reloadData()
        
        }

    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let thumbnailCell = self.thumbnailCollectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCellReuseIdentifier", forIndexPath: indexPath) as? ThumbnailCell
            else {
            fatalError("Unrecognized cell type")
        }
        if self.titles.count > 0 {
            thumbnailCell.thumbnailTitleLabel.text = self.titles[indexPath.row]
        }
//        thumbnailCell.thumbnailImageView.image = self.thumbnailURLs
        return thumbnailCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
