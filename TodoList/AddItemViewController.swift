//
//  AddItemViewController.swift
//  TodoList
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
   
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var txtBoxAdd: UITextField!
    weak var delegate: AddItemViewControllerDelegate?
    weak var itemToEdit : ChecklistItem?
    @IBAction func done() {
        if(itemToEdit == nil){
            let item = ChecklistItem.init(text: txtBoxAdd.text!, checked: false)
            delegate?.addItemViewController(controller: self, didFinishAddingItem: item)
            
        }else{
            itemToEdit?.text = txtBoxAdd.text!
            delegate?.addItemViewController(controller: self, didFinishEditingItem: itemToEdit!)
        }
    }
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(controller: self)
        
    }
    
    func textFieldDidChange(_ textField : UITextField){
        if((textField.text?.characters.count)! > 0){
            doneButton.isEnabled = true
        }
        else
        {
            doneButton.isEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = self.itemToEdit {
            title = "Edit Item"
            txtBoxAdd.text = item.text
            doneButton.isEnabled = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtBoxAdd.becomeFirstResponder()
        textFieldDidChange(txtBoxAdd)
        txtBoxAdd.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
}
protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)

}
