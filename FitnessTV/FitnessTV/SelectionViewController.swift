
import UIKit

enum Workout: String {
    case HIIT
    case Weights
    case Yoga
    case SevenMin
}

extension Workout: CustomStringConvertible {
    var description: String {
        return "\(rawValue)"
    }
}

enum Time: Int {
    case Ten = 10
    case TenToThirty = 30
    case GreaterThanThiry = 31
}


class SelectionViewController: UIViewController {
    var selectedWorkout = ""
    var selectedTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didSelectHIITWorkout(sender: AnyObject) {
        self.selectedWorkout = Workout.HIIT.description
    }
    
    @IBAction func didSelectWeightsWorkout(sender: AnyObject) {
        self.selectedWorkout = Workout.Weights.description
    }
    
    @IBAction func didSelect10Min(sender: AnyObject) {
        self.selectedTime = Time.Ten.rawValue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WorkoutDetail" {
            if let destinationVC : WorkoutDetailViewController = segue.destinationViewController as? WorkoutDetailViewController {
                
                destinationVC.selectedWorkout = self.selectedWorkout
                destinationVC.selectedTime = self.selectedTime
                
            }
        }
    }
}

