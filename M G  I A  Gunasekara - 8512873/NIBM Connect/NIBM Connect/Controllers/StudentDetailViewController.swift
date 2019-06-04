//
//  StudentDetailViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 6/4/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Kingfisher

class StudentDetailViewController: UIViewController {
    
    var selectedStudent: StudentModel?
    
    @IBOutlet weak var studentFirstName: UILabel!
    
    @IBOutlet weak var studentLastName: UILabel!
    
    @IBOutlet weak var studentCity: UILabel!
    
    @IBOutlet weak var studentFbURL: UILabel!
    
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentPhoneNo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData();
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        let url = URL(string:(self.selectedStudent?.profileImageURL)!)
        studentImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        studentImage.kf.setImage(with: url , options:[.processor(processor)])
        studentFirstName.text = self.selectedStudent?.firstName
        studentLastName.text = self.selectedStudent?.lastName
        studentCity.text = self.selectedStudent!.city
        studentPhoneNo.text = self.selectedStudent!.phoneNumber[0]
        studentFbURL.text = self.selectedStudent!.fbProfileURL
        
    }
}
