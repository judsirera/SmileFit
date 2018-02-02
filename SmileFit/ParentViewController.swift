//
//  ParentViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 2/1/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    let colorsList: [String] = {
        return ["Pink", "Purple", "Caki", "Green", "Skin"]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: User.sharedUser.getColor())
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
