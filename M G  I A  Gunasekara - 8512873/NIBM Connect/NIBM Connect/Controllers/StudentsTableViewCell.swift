//
//  StudentsTableViewCell.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 5/26/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Kingfisher

class StudentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentImage: UIImageView!
    
    @IBOutlet weak var studentFullName: UILabel!
    
    @IBOutlet weak var studentCity: UILabel!
    
    func setStudents(student:StudentModel) {
        let url = URL(string:student.profileImageURL)
        studentImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        studentImage.kf.setImage(with: url , options:[.processor(processor)])
        studentFullName.text = "\(student.firstName) \(student.lastName)"
        studentCity.text = student.city
    }
}
