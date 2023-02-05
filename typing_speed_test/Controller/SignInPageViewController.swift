//
//  SignInPageViewController.swift
//  typing_speed_test
//
//  Created by Paul on 2023-01-10.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

 
//public var guestUser = UserInfo(username: "user123", userEmail: "no user sign in", userHighScore: 0 , userID: "wekjtqoiweradsfa")
//var currUser = guestUser
class SignInPageViewController: UIViewController {
    
    
    let formValidation = FormValidation()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    
    
    var showPasswordClicked = true
    
    
    
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        
        
        
        ref = Database.database(url: "https://ios-typing-speed-test-default-rtdb.firebaseio.com/").reference()
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
        
        
        guard let email = emailTextField.text else {return}
        guard let password =  passwordTextField.text else{ return }
        
            Auth.auth().signIn(withEmail: email, password: password){ firebaseResult, error in
                if error != nil{
                    self.showAlert()
                }
                else{   
                    //go to main page
                    print("sign in successfully")
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    UserInfo.userID = userID;
                    print("sign in page : \(UserInfo.userID)")
                    self.performSegue(withIdentifier:"fromSignInToMain" , sender: self)
            }
        }
        resetForm()
        
    }
    
    
    
    @IBAction func backToSignUpPageBUTTON(_ sender: UIButton) {
        performSegue(withIdentifier: "backToSignIn", sender: self)
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
        
        emailError.text = ""
        passwordError.text = ""
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "User log in fail", message: "the email and password you entered did not match our record. Please double check and try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated:true)
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

