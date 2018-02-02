//
//  SetupColorViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/2/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class SetupWelcomeViewController: ParentViewController {

    //MARK: Properties
    @IBOutlet weak var lbl_name: UILabel!
    
    //MARK: Screen activities
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Setup color controller")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl_name.text = User.sharedUser.name
    }

}
