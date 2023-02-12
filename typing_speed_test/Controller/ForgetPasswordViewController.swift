//
//  ForgetPasswordViewController.swift
//  typing_speed_test
//
//  Created by Paul on 2023-02-10.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgetPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var resetPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetButtonPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: resetPasswordTextField.text!){ (error) in
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
                self.resetPasswordTextField.text = ""
                 // reset the textfield
            }
        }
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "forgetPasswordPageBackToSignIn", sender: self)
    }
}
