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
    
    init() {
        let objects = DBManager.instance.getAllObjects()
        for obj in objects{
            todos.append(obj as CheckListItem)
        }
    }
    
    func addNewTodo (_ item: CheckListItem) -> CheckListItem{
        todos.append(item)
        DBManager.instance.addItem(item: item)
        return item
    }
    
    func removeTodo(index: Int){
        let item = todos[index]
        todos.remove(at: index)
        DBManager.instance.deleteItem(item: item)
    }
    
    func moveItemInArray(from: Int, to: Int){// used when reordering
        guard let item = todos[from] as CheckListItem? else{
                return
        }
        
        todos.remove(at: from)
        todos.insert(item, at: to)
    }
    
    func removeMultiple (indexPaths: [IndexPath]){
        var itemsToRemove = [CheckListItem]()
        
        for indexPath in indexPaths{
            if let item = todos[indexPath.row] as CheckListItem?{
                itemsToRemove.append(item)
            }
        }
        
        for itemToRemove in itemsToRemove{
            if let index = todos.firstIndex(of: itemToRemove){
                removeTodo(index: index)
            }
        }
    }
}
