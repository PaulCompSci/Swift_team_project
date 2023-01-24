//
//  ForgotPasswordViewController.swift
//  typing_speed_test
//
//  Created by Kevin Le on 2023-01-24.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func reset_isTapped(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!){ (error) in
            if (error == nil){
                print("Sent!....")
                
            }else{
                print("failed -\(String(describing: error?.localizedDescription))")
            }
        }
        

        
        
    }
    

}
