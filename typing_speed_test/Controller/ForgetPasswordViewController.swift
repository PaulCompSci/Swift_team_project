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
    
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var resetPasswordTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    let formValidation = FormValidation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap empty space to dismiss keyboard
        resetPasswordTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        resetForm()
        
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
                self.resetPasswordTextField.text = ""
                
            }else{
                
                let alert = UIAlertController(title: "UNCUCCESS!!", message: "We are unable to sent you a reset password. Make sure that you typed in a correct email.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Okay", style: .default){(action) in
                    print(action)
                }
                alert.addAction(okeyAction)
                self.present(alert, animated: true, completion: nil)
                // reset the textfield
                self.resetPasswordTextField.text = ""
                 
            }
        }
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "forgetPasswordPageBackToSignIn", sender:
                        self)
    }
    
    
    func resetForm(){
        resetButton.isEnabled = true
        emailError.text = ""
        resetPasswordTextField.text = ""
    }
}


//dimiss keyboard when return key is pressed
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ resetPasswordTextField: UITextField) -> Bool {
        resetPasswordTextField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
