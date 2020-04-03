//
//  ViewController.swift
//  Checklist
//
//  Created by Maid Mehic on 02/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var todoList: TodoList
    
    required init?(coder: NSCoder) {

        todoList = TodoList()

        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            let item = todoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item, rowSelected: true)
            tableView.deselectRow(at: indexPath, animated: true)//ripple effect
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem){
        if let label = cell.viewWithTag(5000) as? UILabel{
            label.text = item.text
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem, rowSelected: Bool = false){
        if rowSelected {
            item.toggleCheck()
        }
        
        if item.checked{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }

}

