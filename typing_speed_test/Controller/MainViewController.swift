//
//  Main.swift
//  typing_speed_test
//
//  Created by Paul on 2023-01-10.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var highestRecordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var ref: DatabaseReference!
    

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        ref = Database.database(url: "https://ios-typing-speed-test-default-rtdb.firebaseio.com/").reference()
        ref.child("Users").child(UserInfo.userID).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let emailLabel = value?["email"] as? String ?? "n/a"
            let highestRecord = value?["highestRecord"] as? Int ?? 0
            self.usernameLabel.text = username
            self.highestRecordLabel.text = String(highestRecord)
            self.emailLabel.text = emailLabel
            
        })
                          
        
        
    }
        
        
        
        
        @IBAction func signOutButtonPressed(_ sender: UIButton) {
            let auth = Auth.auth()
            do{
                print("user sign out")
                try auth.signOut()
                UserInfo.userID = "randomuser123"
                self.dismiss(animated: true , completion: nil)
            }catch let signOutError{
                print("you fail to sign out")
            }
            
        }
    }

        
        
    
    
    
    
    

    
    



