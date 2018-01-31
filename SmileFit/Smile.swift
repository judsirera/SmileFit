//
//  Smile.swift
//  SmileFit
//
//  Created by Judith Sirera Pulido on 1/29/18.
//  Copyright © 2018 Judith Sirera Pulido. All rights reserved.
//

import Foundation


class Smile {
    //MARK: Constants
    static let ID_: String = "id"
    static let TYPE_: String = "type"
    static let DATE_: String = "date"
    
    //MARK: Properties
    let id: String //Timestamp
    let type: Int //0 - Duchenne; //1 - Non-duchenne
    let date: [String:Int]
    
    init(type: Int) {
        let timestamp = DateManager.getTimestamp()
        
        self.id = timestamp.0
        self.type = type
        self.date = timestamp.1
    }
    
    init(type: Int, date: [String: Int], id: String) {
        self.id = id
        self.type = type
        self.date = date
    }
    
    func getSmile() -> ([String: String], [String: [String: Int]]) {
        return ([Smile.ID_: self.id, Smile.TYPE_: String(self.type)], [Smile.DATE_: self.date])
    }
}
