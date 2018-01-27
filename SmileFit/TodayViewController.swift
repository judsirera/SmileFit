//
//  ViewController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/26/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var lbl_hugeNum: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rand:Int = Int(arc4random_uniform(100))
        lbl_hugeNum.text = String(describing: rand)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

