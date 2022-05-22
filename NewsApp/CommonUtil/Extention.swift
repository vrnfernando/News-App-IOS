//
//  Extention.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-21.
//

import Foundation
import UIKit

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        //Add more actions as you see fit
        self.present(alert, animated: true, completion: nil)
    }
}

// Email validate
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

extension UserDefaults{
    
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        //synchronize()
    }
    
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
}

// Set Custom Search Field
func SearchText(to searchBar: UISearchBar, placeHolderText: String) {
    searchBar.barTintColor = UIColor.clear
    searchBar.backgroundColor = UIColor.clear
    searchBar.isTranslucent = true
    searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    
    let searchTextField:UITextField = searchBar.value(forKey: "searchField") as? UITextField ?? UITextField()
    searchTextField.layer.cornerRadius = 18
    searchTextField.layer.borderWidth = 0.2
    searchTextField.layer.borderColor = UIColor.lightGray.cgColor
    searchTextField.textAlignment = NSTextAlignment.left
  
    searchTextField.leftView = nil
    searchTextField.font = UIFont.systemFont(ofSize: 12.0)
    searchTextField.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    
    let image:UIImage = UIImage(named: "ic_search")!
    let imageView:UIImageView = UIImageView.init(image: image)
    searchTextField.rightView = imageView
    searchTextField.backgroundColor = UIColor.white
    searchTextField.rightViewMode = UITextField.ViewMode.always
}




