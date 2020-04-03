//
//  TodoList.swift
//  Checklist
//
//  Created by Maid Mehic on 03/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import Foundation

class TodoList{
    var todos: [CheckListItem] = []
    
    init(){
        let row0Item = CheckListItem()
        let row1Item = CheckListItem()
        let row2Item = CheckListItem()
        let row3Item = CheckListItem()
        let row4Item = CheckListItem()
    
        row0Item.text="Take a jog"
        row1Item.text="Watch a movie"
        row2Item.text="Code an application"
        row3Item.text="Walk a dog"
        row4Item.text="Study design patterns"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
    }
}
