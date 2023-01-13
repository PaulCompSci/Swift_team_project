//
//  ViewController.swift
//  typing_speed_test
//
//  Created by Paul on 2022-12-28.
//

import UIKit

class SignUpPageViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func usernameChanged(_ sender: Any) {
        if let username = usernameTextField.text{
            if let errorMessage = invalidUsername(username){
                usernameError.text = errorMessage
                usernameError.isHidden = false
            }else{
                usernameError.isHidden =  true
            }
            
        }
        if (usernameTextField.text == ""){
            usernameError.text = "*Required"
        }
        checkForValidForm()
    }
    
    
    
    @IBAction func emailChanged(_ sender: Any) {
        
        if let email = emailTextField.text{
            if let errorMessage = invalidEmail(email){
                emailError.text = errorMessage
                emailError.isHidden = false
            }else{
                emailError.isHidden =  true
            }
            
        }
        if (emailTextField.text == ""){
            emailError.text = "*Required"
        }
        
        checkForValidForm()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        
        if let password = passwordTextField.text{
            if let errorMessage = invalidPassword(password){
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
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        resetForm()
    }
    
    func resetForm(){
        signUpButton.isEnabled = false
        
        emailError.isHidden = false
        usernameError.isHidden = false
        passwordError.isHidden = false
        
        emailError.text = "*Required"
        usernameError.text = "*Required"
        passwordError.text = "*Required"
        
        usernameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    func checkForValidForm(){
        if (emailError.isHidden && usernameError.isHidden && passwordError.isHidden){
            signUpButton.isEnabled = true ;
        }
        else{
            signUpButton.isEnabled  = false ;
        }
    }
    
    func invalidEmail(_ value :String) -> String?{
        let regularExpression =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value){
            return  "Invalid Email Address"
        }
        return nil
    }
    
    func invalidPassword(_ value :String) -> String?{
        
        if (value.count < 8){
            return "Password must be at least 8 characters"
        }
        if (containDigit(value)){
            return "Password must contain at least one digit  "
        }
        if(containLowercase(value)){
            return "Password must contain at least 1 lowercase character"
        }
        if (containUppercase(value)){
            return "Password must contain at least 1 uppercase Character"
        }
        return nil
    }
    func invalidUsername(_ value :String) -> String?{
        if (value.count < 4){
            return "Username must have at least 4 character"
        }
        if(containSpecialCharacter(value)){
            return "Username cannot contain special characters"
        }
        return nil
    }
    
    
    
    
    func containDigit(_  value: String? ) -> Bool{
        let regularExpression =  ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func containLowercase(_  value: String? ) -> Bool{
        let regularExpression =  ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func containUppercase(_  value: String? ) -> Bool{
        let regularExpression =  ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containSpecialCharacter(_ value: String? ) -> Bool{
        let characterset = CharacterSet(charactersIn:
           "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if (value?.rangeOfCharacter(from: characterset.inverted)) != nil{
            return true
        }
        
        return false
    }
}

