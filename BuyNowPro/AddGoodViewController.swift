import UIKit
import Firebase

class AddJokeViewController: UIViewController {
    
    @IBOutlet weak var jokeField: UITextField!
    var currentUsername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            
            let currentUser = snapshot.value.objectForKey("username") as! String
            
            print("Username: \(currentUser)")
            self.currentUsername = currentUser
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func saveJoke(_ sender: AnyObject) {
        let jokeText = jokeField.text
        
        if jokeText != "" {
            
           
            
            let newJoke: Dictionary<String, AnyObject> = [
                "jokeText": jokeText! as AnyObject,
                "votes": 0 as AnyObject,
                "author": currentUsername as AnyObject
            ]
            
           
            
            DataService.dataService.createNewJoke(newJoke)
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        
        // unauth() is the logout method for the current user.
        
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        // Remove the user's uid from storage.
        
        UserDefaults.standard.setValue(nil, forKey: "uid")
        
        // Head back to Login!
        
        let loginViewController = self.storyboard!.instantiateViewController(withIdentifier: "Login")
        UIApplication.shared.keyWindow?.rootViewController = loginViewController
    }
}
