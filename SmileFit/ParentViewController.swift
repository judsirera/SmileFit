//
//  ParentViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/1/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = User.sharedUser.getColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
