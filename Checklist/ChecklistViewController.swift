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
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    required init?(coder: NSCoder) {
        
        todoList = TodoList()
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem //edit button by table view controller
        
        tableView.allowsMultipleSelectionDuringEditing = true; //show select buttons when editing
        
        manageDeleteBarButton(isEditingTableView: false, hasSelectedItems: false)
    }
    
    @IBAction func deleteMultipleItems(){
        if let selectedRowsIndexPaths = tableView.indexPathsForSelectedRows{
            todoList.removeMultiple(indexPaths: selectedRowsIndexPaths)
            
            tableView.beginUpdates() //begin series of updates
            tableView.deleteRows(at: selectedRowsIndexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//return number of rows
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//make cell for every row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = todoList.todos[indexPath.row]
        
        configureText(for: cell, with: item)
        configureLineThrough(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//handle row selection
        if(!tableView.isEditing){
            if let cell = tableView.cellForRow(at: indexPath){
                let item = todoList.todos[indexPath.row]
                configureLineThrough(for: cell, with: item, rowSelected: true)
                tableView.deselectRow(at: indexPath, animated: true)//ripple effect
            }
        } else {
            if tableView.indexPathsForSelectedRows != nil {
                manageDeleteBarButton(isEditingTableView: true, hasSelectedItems: true)
            } else {
                manageDeleteBarButton(isEditingTableView: true, hasSelectedItems: false)
            }
            
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
        
        if tableView.indexPathsForSelectedRows != nil {
            manageDeleteBarButton(isEditingTableView: tableView.isEditing, hasSelectedItems: true)
        }else{
            manageDeleteBarButton(isEditingTableView: tableView.isEditing, hasSelectedItems: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { //handle reorder
        
        todoList.moveItemInArray(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { //handle row deletion
        
        todoList.removeTodo(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //        tableView.reloadData()
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem){
        if let checkListItemCell = cell as? CheckListItemTableViewCell{
            checkListItemCell.checkItemLabel.text = item.text
        }
    }
    
    func configureLineThrough(for cell: UITableViewCell, with item: CheckListItem, rowSelected: Bool = false){
        if rowSelected {
            item.toggleCheck()
        }
        
        if let checkListItemCell = cell as? CheckListItemTableViewCell{
            if item.checked{
                manageLineThrough(checkListItemCell.checkItemLabel, 2)
            }else{
                manageLineThrough(checkListItemCell.checkItemLabel, 0)
            }
        }
    }
    
    func manageLineThrough(_ label: UILabel, _ lineThroughValue: Int){
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: label.text!)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: lineThroughValue, range: NSMakeRange(0, attributeString.length))
        
        label.attributedText = attributeString
    }
    
    func manageDeleteBarButton(isEditingTableView: Bool, hasSelectedItems: Bool){
        if isEditingTableView && hasSelectedItems{
            deleteBarButton.title = "Delete"
            deleteBarButton.isEnabled = true;
        } else {
            deleteBarButton.title = ""
            deleteBarButton.isEnabled = false;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {// become a delegate of AddItemViewController
        if segue.identifier == "AddItemSegue"{
            if let addItemViewController = segue.destination as? AddItemViewController{
                addItemViewController.delegate = self
            }
        }else if segue.identifier == "EditItemSegue"{
            if let addItemViewController = segue.destination as? AddItemViewController{
                if let cell = sender as? UITableViewCell{
                    if let indexPath = tableView.indexPath(for: cell){
                        addItemViewController.itemToEdit = todoList.todos[indexPath.row]// send data to addItemViewController
                        addItemViewController.delegate = self
                    }
                }
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
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem) {
        //        tableView.reloadData()
        if let index = todoList.todos.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        
    }
}

