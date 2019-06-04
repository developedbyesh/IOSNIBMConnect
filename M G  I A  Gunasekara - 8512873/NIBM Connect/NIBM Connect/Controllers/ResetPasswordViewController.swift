//
//  ResetPasswordViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 5/26/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    private lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func resetPwdButton(_ sender: UIButton) {
        
        //self.loadingView.alpha = CGFloat(1.0)
        
        if (emailText.text?.isEmpty)!{
            //self.loadingView.alpha = CGFloat(0.0)
            let alert = UIAlertController(title: "Error Login", message:"Please Enter your Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        else if (currentUser?.email != emailText.text){
            //self.loadingView.alpha = CGFloat(0.0)
            let alert = UIAlertController(title: "Invalid Email", message:"Enter Correct Email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        else{
            //reset password
            let resetEmail = self.emailText.text!
            Auth.auth().sendPasswordReset(withEmail: resetEmail, completion: { (error) in
                //Make sure you execute the following code on the main queue
                DispatchQueue.main.async {
                    //Use "if let" to access the error, if it is non-nil
                    if let error = error {
                        //self.loadingView.alpha = CGFloat(0.0)
                        let alert = UIAlertController(title: "Password Reset Error", message:error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        return
                    } else {
                        //self.loadingView.alpha = CGFloat(0.0)
                        let alert = UIAlertController(title: "Successful!", message:"Email Reset Done!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {actoin in  self.passwordRestDone()}))
                        self.present(alert, animated: true)
                    }
                }
            })
        }
        
    }
    
    //Password reset Ok Handler function
    func passwordRestDone(){
        print("Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    

}
