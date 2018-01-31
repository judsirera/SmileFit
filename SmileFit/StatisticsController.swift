//
//  HistoryController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/30/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit

class StatisticsController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var lbl_dateTag: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_numOfSmiles: UILabel!
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDate()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNumOfSmiles()
        self.prepareStatistics(smiles: User.sharedUser.smiles, level: DateManager.MONTH_)
    }
    
    //MARK: Date
    func setDate() {
        lbl_dateTag.text = "Today"
        lbl_date.text = DateManager.getDate(date: DateManager.today)
    }
    
    
    //MARK: Init Views
    func setNumOfSmiles() {
        lbl_numOfSmiles.text = String(User.sharedUser.smiles.count)
    }
    
    
    //MARK: Statistics funcs
    func prepareStatistics(smiles: [Smile], level: String) -> [Int] {
        //Prepare date format for comparing
        let date = DateManager.today
        let dateA: [String: Int] = DateManager.getFirebaseFormat(arrayDate: DateManager.dateToArrayDate(date: date))
        
        //Init array for adding num of smiles
        var count:[Int]
        switch level {
        case DateManager.YEAR_:
            count = Array(repeating: 0, count: 12)
        case DateManager.MONTH_:
            let interval = Calendar.current.dateInterval(of: .month, for: date)!
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!
            
            count = Array(repeating: 0, count: days)
        case DateManager.HOUR_:
            count = Array(repeating: 0, count: 60)
        case DateManager.MINUTE_:
            count = Array(repeating: 0, count: 60)
        default:
            //Day default
            count = Array(repeating: 0, count: 24)
        }
        
        //Count smiles
        for s in smiles {
            if (DateManager.areDatesEqual(dateA: dateA, dateB: s.date, accuracy: level)) {
                count[s.date[level]! - 1] += 1
            }
        }
        
        return count
    }
 
}
