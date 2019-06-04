//
//  HomeworkTableViewCell.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 6/4/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {

    @IBOutlet weak var homeWorkTxt: UILabel!
    
    func setHomework(homework:String){
        self.homeWorkTxt.text = homework
    }
    
}
