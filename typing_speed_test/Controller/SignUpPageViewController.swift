//
//  ViewController.swift
//  typing_speed_test
//


import UIKit
import Firebase


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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

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
        if (emailTextField.text == ""){
            emailError.text = "*Required"
        }
        
        if let username = usernameTextField.text{
            if let errorMessage = formValidation.invalidUsername(username){
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
    
    @IBAction func passwordChanged(_ sender: Any) {
        
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
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        // still not sure how to add in user name
        
         guard let email = emailTextField.text else{ return }
         guard let password = passwordTextField.text else { return }
        
        
         Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
             if let e = error {
                 print("error");
             }
             else{
                 // go to homestreen or something

                 self.performSegue(withIdentifier: "goToNext", sender: self)
             }

         }
        
    }
    

    /*
     * Note: this reset form only can be used for signUpPage
     */
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
