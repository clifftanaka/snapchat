//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Cliff Tanaka on 2017/03/14.
//  Copyright © 2017 kurifu. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
