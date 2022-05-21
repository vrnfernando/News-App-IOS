//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Kasper - Vishwa on 2022-05-21.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    //Outlet: UITextField
    @IBOutlet weak var user_email: UITextField!
    @IBOutlet weak var user_pwd: UITextField!
    
    //Outlet: UIButton
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var btn_register: UIButton!
    
    //Outlet: UIView
    @IBOutlet weak var view_loginContain: UIView!
    
    //CoreData: persistentContainer
    let persistentContainer = CoreDataManager().persistentContainer
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.isLoggedIn(){
            
            moveToDashBoard()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uiUpdate()
        
    }
    
    // update UI components
    func uiUpdate(){
        
        //Set Corner Radius
        btn_login.layer.cornerRadius    = 8
        btn_register.layer.cornerRadius = 8
        
        view_loginContain.layer.cornerRadius = 8
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // IBActions
    @IBAction func action_login(_ sender: Any) {
        
        if isValidEmail(user_email.text!) && user_pwd.text != "" {
            
            let userData = fetchUserDetails(withEmail: user_email.text!)
            if userData != nil {
                
                if userData?.password == user_pwd.text! {
                    
                    //Login Success
                    print("Login Success")
                    UserDefaults.standard.setLoggedIn(value: true)
                    moveToDashBoard()
                    
                }else{
                    
                    //Login Error
                    showAlert(alertText: "Error", alertMessage: "Invalid Password, Please try again!")
                    
                }
            }
            
            
        }else{
            showAlert(alertText: "Error", alertMessage: "Invalid Email, Please try again!")
        }
    }
    
    
    @IBAction func action_register(_ sender: Any) {
        
        if isValidEmail(user_email.text!) && user_pwd.text != "" {
            
            if createUserDetails(email: user_email.text!, password: user_pwd.text!) != nil {
                
                showAlert(alertText: "Success", alertMessage: "User Created!")
                
            }else{
                
                showAlert(alertText: "Error", alertMessage: "Somthing Went Wrong, Please try again!")
                
            }
        }else{
            showAlert(alertText: "Error", alertMessage: "Invalid Email, Please try again!")
        }
    }
    
    //Login
    func moveToDashBoard(){
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation") as! UINavigationController
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    
    // Create User
    func createUserDetails(email: String, password: String) -> UserDetails? {
        
        let context = persistentContainer.viewContext
        
        let userDetails = NSEntityDescription.insertNewObject(forEntityName: "UserDetails", into: context) as! UserDetails // NSManagedObject
        
        userDetails.email    = email
        userDetails.password = password
        
        do {
            try context.save()
            return userDetails
        }catch let createError {
            print("Failed to create: \(createError) ")
        }
        
        return nil
    }
    
    // Get User Details by email
    func fetchUserDetails(withEmail  email: String) -> UserDetails? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserDetails>(entityName: "UserDetails")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let data = try context.fetch(fetchRequest)
            return data.first
            
        }catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        
        return nil
    }

}
