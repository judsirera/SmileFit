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
    static let YEAR: String = "year"
    static let MONTH: String = "month"
    static let DAY: String = "day"
    static let HOUR: String = "hour"
    static let MINUTE: String = "minute"
    static let SECOND: String = "second"
    
    static let TAG_LIST: [String] = [DateManager.YEAR,
                                    DateManager.MONTH,
                                    DateManager.DAY,
                                    DateManager.HOUR,
                                    DateManager.MINUTE,
                                    DateManager.SECOND]
    
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
        return [DateManager.YEAR: arrayDate[0],
                DateManager.MONTH: arrayDate[1],
                DateManager.DAY: arrayDate[2],
                DateManager.HOUR: arrayDate[3],
                DateManager.MINUTE: arrayDate[4],
                DateManager.SECOND: arrayDate[5]]
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
        case DateManager.YEAR:
            dateFormatter.dateFormat = "yyyy"
        case DateManager.MONTH:
            dateFormatter.dateFormat = "MMMM' 'yyyy"
        case DateManager.DAY:
            dateFormatter.dateFormat = "MMMM d', 'yyyy"
        case DateManager.HOUR:
            dateFormatter.dateFormat = "MMMM d', 'yyyy' at 'HH"
        case DateManager.MINUTE:
            dateFormatter.dateFormat = "MMMM d', 'yyyy' at 'HH':'mm"
        default:
            dateFormatter.dateStyle = .medium
        }
        
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date)
    }
    
    
}
