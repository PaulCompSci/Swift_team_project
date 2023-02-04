//
//  ViewController.swift
//  typing_speed_test
//
//  Created by Paul on 2022-12-28.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpPageViewController: UIViewController{

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    let formValidation = FormValidation()
    var showPasswordClicked = true
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         ref = Database.database(url: "https://ios-typing-speed-test-default-rtdb.firebaseio.com/").reference()
        
        
        //removing keyboard while tapping on empty place
        usernameTextField.delegate = self
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
    
    
    @IBAction func usernameChanged(_ sender: Any) {
        
        
        if let username = usernameTextField.text{
            if let errorMessage = formValidation.invalidUsername(username){
                usernameError.text = errorMessage
                usernameError.isHidden = false
            }else{
                usernameError.isHidden =  true
            }
            
        }
        
       checkForValidForm()
    }
    
    
    @IBAction func emailChanged(_ sender: Any) {
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
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTextField.text{
            if let errorMessage = formValidation.invalidPassword(password){
                passwordError.text = errorMessage
                passwordError.isHidden = false
            }else{
                passwordError.isHidden =  true
            }
                    
        }
        
        checkForValidForm()
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password =  passwordTextField.text else{ return }
        let username  = usernameTextField.text
        let record  = 0
    
            Auth.auth().createUser(withEmail: email, password: password){ firebaseResult, error in
                if let e = error{
                    self.showAlert()
                }
                else{
                //go to our homescreen
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    self.ref.child("Users").child(userID).setValue(["username": username ,"email": email,  "password":password, "highestRecord": record])
                    UserInfo.userID = userID
                    print(UserInfo.userID)
                    self.performSegue(withIdentifier:"signUpSuccessfultoMain" , sender: self)
            }
        }
        resetForm()
    }
    
    
    @IBAction func signInAsGuestPressed(_ sender: Any) {
        UserInfo.userID = "randomuser123"
        self.performSegue(withIdentifier: "signInAsGuesttoMain", sender: self)
    }
    

    /*
     * Note: this reset form only can be used for signUpPage
     */
    func resetForm(){
        signUpButton.isEnabled = false
        
        emailError.isHidden = false
        usernameError.isHidden = false
        passwordError.isHidden = false
        
        emailError.text = ""
        usernameError.text = ""
        passwordError.text = ""
        
        usernameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    /*
     * Note : function below only can be use for sign  up page
     */
    func checkForValidForm(){
        if (emailError.isHidden && usernameError.isHidden && passwordError.isHidden){
            signUpButton.isEnabled = true ;
        }
        else{
            signUpButton.isEnabled  = false ;
            
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Fail to create account", message: "Email already Exists, please try another email account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated:true)
    }
    
}


extension SignUpPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
    if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
    nextField.becomeFirstResponder()
    } else {
    textField.resignFirstResponder()
    }
    return false
    }
}
