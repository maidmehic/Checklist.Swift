//
//  DBManager.swift
//  Checklist
//
//  Created by Maid Mehic on 26/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    static let instance = DBManager()
    private var database: Realm
    
    private init(){
        database = try! Realm()
//        deleteAllFromDatabase()
    }
    
    func addItem(item: CheckListItem) {
        try! database.write{
            database.add(item)
            print("Added new object \(item.creationDate)")
        }
    }
    
    func getAllObjects() -> Results<CheckListItem>{
        return database.objects(CheckListItem.self)
    }
    
    func deleteItem(item: CheckListItem){
        try! database.write {
           database.delete(item)
        }
    }
    
    func deleteAllFromDatabase()  {
         try! database.write {
             database.deleteAll()
         }
    }
    
    func updateToDo(item: CheckListItem, updated: CheckListItem)  {
         try! database.write {
            item.text = updated.text
            item.checked = updated.checked
         }
    }
    
}
