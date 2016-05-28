
import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailTitleLabel: UILabel!
    
    convenience init (title: String, data: NSData ) {
        self.init()
        self.thumbnailImageView.image = UIImage.init(data: data)
        self.thumbnailTitleLabel.text = title
    }
}
