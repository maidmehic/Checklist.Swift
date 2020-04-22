//
//  AddItemViewController.swift
//  Checklist
//
//  Created by Maid Mehic on 03/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: CheckListItem )
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: CheckListItem)
}

class AddItemViewController: UITableViewController {
    
    weak var delegate: AddItemViewControllerDelegate?
    
    weak var itemToEdit: CheckListItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarItem!
    @IBOutlet weak var cancelBarItem: UIBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
        
        if itemToEdit != nil{
            doneBarButton.isEnabled = true
            textField.text = itemToEdit?.text
            navigationItem.title = "Edit Item"
            doneBarButton.title = "Edit"
        }else{
            doneBarButton.isEnabled = false
            navigationItem.title = "Add Item"
            doneBarButton.title = "Add"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()//focus textField
    }
    
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func add(){
        navigationController?.popViewController(animated: true)
        
        if let item = itemToEdit,
            let text = textField.text{
            item.text = text
            delegate?.addItemViewController(self, didFinishEditing: item)
        }
        else{
            let item = CheckListItem()
            if let textFieldText = textField.text{
                item.text = textFieldText
            }
            item.checked = false
            
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {//disable row from being selected
        return nil
    }
}

extension AddItemViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//close the keyboard
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        
        return true
    }
}

