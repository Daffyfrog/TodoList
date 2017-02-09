//
//  ViewController.swift
//  TodoList
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var checklistItems = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checklistItems.append((ChecklistItem(text: "Item1", checked: false)))
        checklistItems.append(ChecklistItem(text: "Mettre à jour XCode", checked: false))
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureCheckmarkForCell(cell: cell, withChecklistItem: checklistItems[indexPath.row])
        configureTextForCell(cell: cell, withChecklistItem: checklistItems[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            checklistItems[indexPath.row].toggleCheck();
            configureCheckmarkForCell(cell : cell, withChecklistItem: checklistItems[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"
        {
            let nav = segue.destination as? UINavigationController
            let destination = nav?.topViewController as? AddItemViewController
            destination?.delegate = self
        }
        else if segue.identifier == "EditItem"
        {
            let nav = segue.destination as? UINavigationController
            let destination = nav?.topViewController as? AddItemViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                destination?.itemToEdit = checklistItems[indexPath.row]
            }
            destination?.delegate = self
        }
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        if let label = cell.viewWithTag(1001) as?UILabel{
            label.isHidden = !item.checked
        }
        
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        if let label = cell.viewWithTag(1000) as?UILabel{
            label.text = item.text
        }
    }
    @IBAction func addAction(_ sender: Any) {
        addDummyTodo();
    }
    func addDummyTodo(){
        checklistItems.append(ChecklistItem(text: "Éclater le mac", checked: false))
        tableView.insertRows(at: [IndexPath(row : checklistItems.count-1, section : 0)],  with: UITableViewRowAnimation.automatic)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            checklistItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
extension ChecklistViewController : AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismiss(animated : true)
    }
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        checklistItems.append(item)
        tableView.insertRows(at: [IndexPath(row : checklistItems.count-1, section : 0)],  with: UITableViewRowAnimation.automatic)
        dismiss(animated : true)
    }
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem){
        if checklistItems.index(where:{ $0 === item }) != nil{
            tableView.reloadData()
        }
        dismiss(animated : true)
    }
}
