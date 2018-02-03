//
//  ProfileViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/2/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class ProfileViewController: ParentViewController {

    //MARK: Properties
    @IBOutlet weak var lbl_name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLabelName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setLabelName() {
        self.lbl_name.text = User.sharedUser.name
    }

}
