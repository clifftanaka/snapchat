//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Cliff Tanaka on 2017/03/22.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = snap.desc
        imageView.sd_setImage(with: URL(string: snap.imageUrl))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              .currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("We deleted the pic")
        }
    }
}
