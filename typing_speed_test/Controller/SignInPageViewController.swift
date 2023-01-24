//
//  SignInPageViewController.swift
//  typing_speed_test
//
//  Created by Paul on 2023-01-10.
//

import UIKit
import Firebase

class SignInPageViewController: UIViewController {
    
    
    let formValidation = FormValidation()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    var showPasswordClicked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        resetForm()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func showPasswordButtonPressed(_ sender: UIButton) {
            if  showPasswordClicked{
                passwordTextField.isSecureTextEntry = false
            }else {
                passwordTextField.isSecureTextEntry = true
            }
            showPasswordClicked = !showPasswordClicked
        
    }
    
    
    @IBAction func emailEntered(_ sender: Any) {
        if (emailTextField.text == ""){
            emailError.text = "*Required"
        }
        
        if let email = emailTextField.text{
            if let errorMessage = formValidation.invalidEmail(email){
                emailError.text = errorMessage
                emailError.isHidden = false
            }else{
                emailError.isHidden =  true
            }
            
        }
        
        checkForValidForm()
    }
    
    
    @IBAction func passwordEntered(_ sender: UITextField) {
        if (emailTextField.text == ""){
            emailError.text = "*Required"
        }
        
        if let password = passwordTextField.text{
            if let errorMessage = formValidation.invalidPassword(password){
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }else{
                passwordError.isHidden =  true
            }
            
        }
        if (passwordTextField.text == ""){
            passwordError.text = "*Required"
        }
        checkForValidForm()
    }
    
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
        guard let email = emailTextField.text else{ return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("Error in Authentification");
            }
            else{
                // go to homestreen or something
                self.performSegue(withIdentifier: "goToNext", sender: self)
            }

        }
        resetForm()
        
    }
    
    
    
    @IBAction func backToSignUpPageBUTTON(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func checkForValidForm(){
        if (emailError.isHidden && passwordError.isHidden){
            signInButton.isEnabled = true ;
        }
        else{
            signInButton.isEnabled  = false ;
        }
    }
    
    
    func resetForm(){
        signInButton.isEnabled = false
        
        emailError.isHidden = false
        passwordError.isHidden = false
        
        emailError.text = "*Required"
        passwordError.text = "*Required"
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    
}



extension SignInPageViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
        nextField.becomeFirstResponder()
        } else {
        textField.resignFirstResponder()
        }
        return false
        }
    }

