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
    
    func addNewTodo (_ item: CheckListItem) -> CheckListItem{
        todos.append(item)
        return item
    }
    
    func removeTodo(index: Int){
        todos.remove(at: index)
    }
    
    private func getRandomTitle () -> String {
        var titles = ["New todo item", "Generic todo", "Fill me out", "I need something to do", "Much todo about nothing"]
        
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
