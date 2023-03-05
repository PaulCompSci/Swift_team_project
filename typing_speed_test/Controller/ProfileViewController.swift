//
//  ProfileViewController.swift
//  typing_speed_test
//
//  Created by Kevin Le on 2023-02-25.
//

import UIKit
import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fifteenLabel: UILabel!
    @IBOutlet weak var thirtyLabel: UILabel!
    @IBOutlet weak var sixtyLabel: UILabel!
    @IBOutlet weak var currentRankLabel: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database(url: "https://ios-typing-speed-test-default-rtdb.firebaseio.com/").reference()
        ref.child("Users").child(UserInfo.userID).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
           
            let sixty = value?["60second"] as? Int ?? 0
            let thirty = value?["30second"] as? Int ?? 0
            let fifteen = value?["15second"] as? Int ?? 0

            self.usernameLabel.text   = username
            
            self.sixtyLabel.text = "60s: " + String(sixty) + " wpm"
            self.fifteenLabel.text = "15s: " + String(fifteen) + " wpm"
            self.thirtyLabel.text = "30s: " + String(thirty) + " wpm"
            self.currentRankLabel.text = "Current Rank: "+String(1) + " wpm"
        })


    }
    

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMain", sender:
                        self)
    }

}

