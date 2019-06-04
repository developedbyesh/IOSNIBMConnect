//
//  MyProfileViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 6/4/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import LocalAuthentication

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var DateofBirth: UILabel!
    
    @IBOutlet weak var phoneno: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var unauthorizedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unauthorizedView.alpha = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.unauthorizedView.alpha = 1
        authenticationFingerPrint()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.unauthorizedView.alpha = 1
    }
    
    //Load data from firebase
    func loadUserData(){
        //        var tempFriendList: [Friend] = []
        Database.database().reference().child("MyAccount").observeSingleEvent(of: .value, with: {( snapshot ) in
            
            if let dictionary = snapshot.value as?  NSDictionary{
                let firstname = dictionary["firstname"] as! String
                let lastname = dictionary["lastname"] as! String
                let profileimageurl = dictionary["imageurl"] as! String
                let phonenumber = dictionary["phonenumber"] as! String
                let age = dictionary["age"] as! Int
                let birthdate = dictionary["birthdate"] as! String
                
                print(firstname)
                
                let url = URL(string:profileimageurl)
                self.photo.kf.indicatorType = .activity
                let processor = RoundCornerImageProcessor(cornerRadius: 20)
                self.photo.kf.setImage(with: url , options:[.processor(processor)])
                let profileName = "\(firstname) \(lastname)"
                print(profileName)
                self.fullName.text = "\(firstname) \(lastname)"
                self.age.text = age.description
                self.phoneno.text = phonenumber
                self.DateofBirth.text = birthdate
                
            }
            else{
                print("No values")
            }
        })
    }
    
    //Authentication fingerprint function
    func authenticationFingerPrint(){
        let authContext = LAContext()
        let authReason = "Please use Touch ID to access Your Account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success,error) -> Void in
                if success{
                    print("Authentication Success")
                    DispatchQueue.main.async{
                        self.loadUserData()
                        self.unauthorizedView.alpha = 0
                    }
                }
                if error != nil{
                    self.populateAlertBox(title: "Touch ID Error", message: (error?.localizedDescription)!)
                }
            })
        }
        else{
            populateAlertBox(title: "Touch ID Error", message: (authError?.localizedDescription)!)
            print(authError?.localizedDescription)
        }
    }
    
    //Populate alter function
    func populateAlertBox(title:String,message:String){
        
        //Popup alert
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title:"Ok", style: .default, handler:{action in self.showError()})
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    //Error show function
    func showError(){
        self.unauthorizedView.alpha = 1
    }
}
