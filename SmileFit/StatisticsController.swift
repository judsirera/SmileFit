//
//  HistoryController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/30/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit
import Charts

class StatisticsController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var lbl_dateTag: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_numOfSmiles: UILabel!
    @IBOutlet weak var chtChart: LineChartView!
    
    
    var numbers:[Double] = []
    
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
        let dataset = self.prepareStatistics(smiles: User.sharedUser.smiles, toDisplay: DateManager.DAY_)
        self.updateGraph(dataset: dataset)
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
    func prepareStatistics(smiles: [Smile], toDisplay: String) -> [Int] {
        //Prepare date format for comparing
        let date = DateManager.today
        let dateA: [String: Int] = DateManager.getFirebaseFormat(arrayDate: DateManager.dateToArrayDate(date: date))
        
        //Init array for adding num of smiles
        var dataset:[Int]
        switch toDisplay {
        case DateManager.YEAR_: //Display Months of year
            dataset = Array(repeating: 0, count: 12)
        case DateManager.MONTH_: //Display Days of month
            let interval = Calendar.current.dateInterval(of: .month, for: date)!
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!
            
            dataset = Array(repeating: 0, count: days)
        case DateManager.HOUR_: //Display Minutes of hour
            dataset = Array(repeating: 0, count: 60)
        case DateManager.MINUTE_: //Display Seconds of minute
            dataset = Array(repeating: 0, count: 60)
        default: //Display Hours of day
            //Day default
            dataset = Array(repeating: 0, count: 24)
        }
        
        //Count smiles
        let xAxis: String = DateManager.TAG_LIST[DateManager.TAG_LIST.index(of: toDisplay)! + 1]
        for s in smiles {
            if (DateManager.areDatesEqual(dateA: dateA, dateB: s.date, accuracy: toDisplay)) {
                dataset[s.date[xAxis]!] += 1
            }
        }
        
        return dataset
    }
    
    func updateGraph(dataset:[Int]) {
        print(dataset)
        var lineCharEntry = [ChartDataEntry]()
        
        for i in 0..<dataset.count {
            let value = ChartDataEntry(x: Double(i), y: Double(dataset[i]))
            lineCharEntry.append(value)
        }
        
        let lineRepresentation:LineChartDataSet = LineChartDataSet(values: lineCharEntry, label: "")
        lineRepresentation.colors = [UIColor.black]
        
        let dataChart:LineChartData = LineChartData()
        dataChart.addDataSet(lineRepresentation)
        
        self.chtChart.data = dataChart
        self.chtChart.chartDescription?.text = ""
    }

 
}
