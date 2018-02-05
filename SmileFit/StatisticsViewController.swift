//
//  HistoryController.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/30/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: ParentViewController {

    //MARK: Properties
    
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_numOfSmiles: UILabel!
    @IBOutlet weak var chartView: BarChartView!
    
    
    var toDisplay:String = DateManager.DAY
    var dataset:[Int] = []
    let integerFormatter = NumberFormatter()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDate()
        self.setGraphDesign()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNumOfSmiles()
        
        self.prepareStatistics(smiles: User.sharedUser.smiles)
        self.upgradeBarChart()
    }
    
    //MARK: Date
    func setDate() {
        lbl_date.text = DateManager.getDate(date: DateManager.today, toDisplay: self.toDisplay)
    }
    
    
    //MARK: Formatter
    func setFormatter() {
        self.integerFormatter.minimumFractionDigits = 0
        self.integerFormatter.maximumFractionDigits = 1
    }
    
    
    //MARK: Init Views
    func setNumOfSmiles() {
        lbl_numOfSmiles.text = String(User.sharedUser.getNumOfSmiles())
    }
    
    
    //MARK: Statistics funcs
    func prepareStatistics(smiles: [Smile]){
        //Prepare date format for comparing
        let date = DateManager.today
        let dateA: [String: Int] = DateManager.getFirebaseFormat(arrayDate: DateManager.dateToArrayDate(date: date))
        
        //Init array for adding num of smiles
        switch self.toDisplay {
        case DateManager.YEAR: //Display Months of year
            self.dataset = Array(repeating: 0, count: 13)
        case DateManager.MONTH: //Display Days of month
            let interval = Calendar.current.dateInterval(of: .month, for: date)!
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!
            
            self.dataset = Array(repeating: 0, count: days + 1)
        case DateManager.HOUR: //Display Minutes of hour
            self.dataset = Array(repeating: 0, count: 60)
        case DateManager.MINUTE: //Display Seconds of minute
            self.dataset = Array(repeating: 0, count: 60)
        default: //Display Hours of day
            //Day default
            self.dataset = Array(repeating: 0, count: 24)
        }
        
        //Count smiles
        let xAxis: String = DateManager.TAG_LIST[DateManager.TAG_LIST.index(of: self.toDisplay)! + 1]
        
        for s in smiles {
            if (DateManager.areDatesEqual(dateA: dateA, dateB: s.date, accuracy: self.toDisplay)) {
                self.dataset[s.date[xAxis]!] += 1
            }
        }
    }
    
    func upgradeBarChart() {
        var barChartEntry = [BarChartDataEntry]()
        
        var initIndex:Int = 0
        if (self.toDisplay == DateManager.MONTH || self.toDisplay == DateManager.YEAR) {
            initIndex = 1
        }
        for i in initIndex..<self.dataset.count {
            let value = BarChartDataEntry(x: Double(i), y: Double(self.dataset[i]))
            barChartEntry.append(value)
        }
        
        let barRepresentation:BarChartDataSet = BarChartDataSet(values: barChartEntry, label: "")
        barRepresentation.colors = [UIColor(named: "Dark")!]
        barRepresentation.valueFormatter = DefaultValueFormatter(formatter: self.integerFormatter)
        
        let dataChart:BarChartData = BarChartData()
        dataChart.addDataSet(barRepresentation)
        
        self.chartView.data = dataChart
        self.scaleYaxis()
    }
    
    private func setGraphDesign() {
        //Title
        self.chartView.chartDescription?.enabled = false

        //Legend
        self.chartView.legend.enabled = false

        //Axis X
        let axisX = self.chartView.xAxis
        axisX.drawGridLinesEnabled = false
        axisX.labelPosition = .bottom

        //Axis Y
        self.chartView.rightAxis.enabled = false
        let axisY = self.chartView.leftAxis
        axisY.spaceBottom = 0
        axisY.valueFormatter = DefaultAxisValueFormatter(formatter: integerFormatter)
        axisY.axisMinimum = 0
        
    }
    
    func scaleYaxis() {
        self.chartView.leftAxis.labelCount = self.dataset.max()! + 1
        self.chartView.leftAxis.axisMaximum = Double(self.dataset.max()! + 1)
    }

 
}
