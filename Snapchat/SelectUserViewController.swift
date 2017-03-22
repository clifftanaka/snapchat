//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Cliff Tanaka on 2017/03/21.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageUrl : String = ""
    var desc : String = ""
    var uuid : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            let user = User()
            
            user.uid = snapshot.key
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = [
            "from" : FIRAuth.auth()!.currentUser!.email!,
            "description" : desc,
            "imageUrl" : imageUrl,
            "uuid" : uuid
        ]
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }
}
