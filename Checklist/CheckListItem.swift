//
//  CheckListItem.swift
//  Checklist
//
//  Created by Maid Mehic on 03/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    var text: String = ""
    var checked: Bool = false
    
    func toggleCheck(){
        self.checked = !self.checked
    }
}
