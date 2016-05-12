
import UIKit

class WorkoutDetailViewController: UIViewController {
    
    var selectedWorkout: String?
    var selectedTime: Int?
    
    var apiKey: String {
        let client = Client()
        
        if let key = client.retrieveKeyFromPList() {
            return key
        }
        return ""
    }
    
    
}
