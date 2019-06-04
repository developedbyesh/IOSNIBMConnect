//
//  HomeworkViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 6/4/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var homeworkList:[String] = []
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        homeworkList = defaults.object(forKey: "Homework") as? [String] ?? [String]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeworkList = defaults.object(forKey: "Homework") as? [String] ?? [String]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeworkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homework = self.homeworkList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell" ,for: indexPath) as! HomeworkTableViewCell
        
        //Set data to cellview attributes
        cell.setHomework(homework: homework)
        return cell
    }
}
