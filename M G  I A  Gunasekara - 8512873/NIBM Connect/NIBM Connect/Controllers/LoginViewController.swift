//
//  LoginViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 5/26/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var pwdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if (emailText.text?.isEmpty)!{
            //self.loadingView.alpha = CGFloat(0.0)
            let alert = UIAlertController(title: "Error Login", message:"Please Enter your Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        else if (pwdText.text?.isEmpty)!{
            //self.loadingView.alpha = CGFloat(0.0)
            let alert = UIAlertController(title: "Error Login", message:"Please enter your Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        else{
            
            Auth.auth().signIn(withEmail: self.emailText.text!, password: self.pwdText.text!) { [weak self] user, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //self?.loadingView.alpha = CGFloat(0.0)
                    strongSelf.present(alert, animated: true, completion: nil)
                } else {
                    strongSelf.dismiss(animated: true, completion: nil)
                    
                    print(user?.user.uid)
                    
                    //Open next UI
                    //strongSelf.loadingView.alpha = CGFloat(0.0)
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "Home") as! TabBarViewController
                    strongSelf.present(controller, animated: true, completion: nil)
                    //End
                }
            }
        }
    }
    
    
}
