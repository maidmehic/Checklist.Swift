//
//  CheckListItem.swift
//  Checklist
//
//  Created by Maid Mehic on 03/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import Foundation
import RealmSwift

class CheckListItem: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var checked: Bool = false
    @objc dynamic var creationDate: String = Date().toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
    
    override static func primaryKey() -> String? {
        return "creationDate"
    }
}

extension Date {
    func toString(dateFormat format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
