//
//  StudentViewController.swift
//  NIBM Connect
//
//  Created by Yasith Thathsara Senarathne on 5/26/19.
//  Copyright © 2019 Imesh Gunasekara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class StudentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var studentList: [StudentModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadStudentsData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = self.studentList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell" ,for: indexPath) as! StudentsTableViewCell

        //Set data to cellview attributes
        cell.setStudents(student: student)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showStudentDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentDetailViewController{
            destination.selectedStudent = self.studentList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    //Load data from firebase
    func loadStudentsData(){
        //        var tempFriendList: [Friend] = []
        Database.database().reference().child("Friends").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let firstname = dictionary["firstname"] as! String
                let lastname = dictionary["lastname"] as! String
                let profileimageurl = dictionary["imageurl"] as! String
                let phonenumber = dictionary["phonenumber"] as! String
                let fburl = dictionary["fburl"] as! String
                let city = dictionary["city"] as! String
                
                let friend = StudentModel(firstName: firstname,lastName: lastname,profileImageURL: profileimageurl,phoneNumber: [phonenumber],fbProfileURL: fburl,city: city)
                print(firstname , lastname , profileimageurl)
                self.studentList.append(friend)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
}
