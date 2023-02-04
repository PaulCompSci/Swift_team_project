//
//  validation.swift
//  typing_speed_test
//
//  Created by Paul on 2023-01-19.
//

import Foundation


struct FormValidation{
    
    
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
    
    func invalidEmail(_ value :String) -> String?{
        let regularExpression =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
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
    
    
    
}
