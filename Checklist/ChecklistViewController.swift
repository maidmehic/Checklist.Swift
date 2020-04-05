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
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//return number of rows
        return todoList.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//make cell for every row
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//handle row selection
        if let cell = tableView.cellForRow(at: indexPath){
            let item = todoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item, rowSelected: true)
            tableView.deselectRow(at: indexPath, animated: true)//ripple effect
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { //handle row deletion
        
        todoList.removeTodo(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
//        tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// become a delegate of AddItemViewController
        if segue.identifier == "AddItemSegue"{
            if let addItemViewController = segue.destination as? AddItemViewController{
                addItemViewController.delegate = self
            }
        }
    }
}

extension ChecklistViewController: AddItemViewControllerDelegate{
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem) {
      
        let indexPath = IndexPath(row: todoList.todos.count, section: 0)
        _ = todoList.addNewTodo(item)
        tableView.insertRows(at: [indexPath], with: .automatic)
        //        tableView.reloadData()
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        
    }
}

