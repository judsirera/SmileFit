//
//  DateManager.swift
//  DateManagerFit
//
//  Created by Judith Sirera Pulido on 1/30/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import Foundation

class DateManager {
    
    //MARK: Constants
    static let YEAR_: String = "year"
    static let MONTH_: String = "month"
    static let DAY_: String = "day"
    static let HOUR_: String = "hour"
    static let MINUTE_: String = "minute"
    static let SECOND_: String = "second"
    
    static let TAG_LIST: [String] = [DateManager.YEAR_,
                                    DateManager.MONTH_,
                                    DateManager.DAY_,
                                    DateManager.HOUR_,
                                    DateManager.MINUTE_,
                                    DateManager.SECOND_]
    
    static let today: Date = Date()
    
    init() {}
    
    static func getTimestamp() ->  (String, [String: Int]){
        let descomposed:[Int] = self.dateToArrayDate(date: Date())
        
        var timestamp: String = ""
        for s in descomposed {
            timestamp += String(s)
        }
        
        let date = DateManager.getFirebaseFormat(arrayDate: descomposed)
        
        return (timestamp, date)
    }
    
    static func dateToArrayDate(date: Date) -> [Int] {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let year: Int =  components.year as Int!
        let month: Int = components.month as Int!
        let day: Int = components.day as Int!
        let hour: Int = components.hour as Int!
        let minute: Int = components.minute as Int!
        let second: Int = components.second as Int!
        
        return [year, month, day, hour, minute, second]
    }
    
    static func getFirebaseFormat(arrayDate: [Int]) -> [String: Int] {
        return [DateManager.YEAR_: arrayDate[0],
                DateManager.MONTH_: arrayDate[1],
                DateManager.DAY_: arrayDate[2],
                DateManager.HOUR_: arrayDate[3],
                DateManager.MINUTE_: arrayDate[4],
                DateManager.SECOND_: arrayDate[5]]
    }
    
    static func areDatesEqual(dateA: [String: Int], dateB: [String: Int], accuracy: String) -> Bool {
        for tag in self.TAG_LIST {
            if (tag == accuracy) { //Final of search
                return dateA[tag] == dateB[tag]
            } else if (dateA[tag] != dateB[tag]) { //Check if are differents
                return false
            }
        }
        return false
    }
    
    static func getDate(date: Date, toDisplay: String) -> String {
        let dateFormatter = DateFormatter()
        
        switch toDisplay {
        case DateManager.YEAR_:
            dateFormatter.dateFormat = "yyyy"
        case DateManager.MONTH_:
            dateFormatter.dateFormat = "MMMM' 'yyyy"
        case DateManager.DAY_:
            dateFormatter.dateFormat = "MMMM d', 'yyyy"
        case DateManager.HOUR_:
            dateFormatter.dateFormat = "MMMM d', 'yyyy' at 'HH"
        case DateManager.MINUTE_:
            dateFormatter.dateFormat = "MMMM d', 'yyyy' at 'HH':'mm"
        default:
            dateFormatter.dateStyle = .medium
        }
        
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date)
    }
    
    
}
