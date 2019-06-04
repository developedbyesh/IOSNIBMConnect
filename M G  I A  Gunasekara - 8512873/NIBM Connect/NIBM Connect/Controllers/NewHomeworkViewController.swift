//
//  NewHomeworkViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 6/4/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit

class NewHomeworkViewController: UIViewController {

    
    @IBOutlet weak var homeworkTxt: UITextView!
    
    var homeworkList:[String] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeworkList = defaults.object(forKey: "Homework") as? [String] ?? [String]()
    }
    
    @IBAction func saveHomeworkBtn(_ sender: UIButton) {
        if (homeworkTxt.text?.isEmpty)!{
            let alert = UIAlertController(title: "Empty Fields", message:"Enter Homework Text", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        homeworkList.append(homeworkTxt.text)
        defaults.set(self.homeworkList, forKey: "Homework")
        //Popup alert
        let alert = UIAlertController(title: "Saved", message:"Homework saved successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: {action in self.dismissView()})
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    //Dismiss view
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
