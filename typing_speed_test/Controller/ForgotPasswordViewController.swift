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
                let alert = UIAlertController(title: "Sent!", message: "An email has been sent to you to reset your password", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Okay", style: .default){(action) in
                    print(action)
                }
                alert.addAction(okeyAction)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "UNCUCCESS!!", message: "We are unable to sent you a reset password. Make sure that you typed in a correct email.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Okay", style: .default){(action) in
                    print(action)
                }
                alert.addAction(okeyAction)
                self.present(alert, animated: true, completion: nil)
                self.emailTextField.text = ""
                 // reset the textfield
            }
        }
        
    }
    

}
