//
//  ViewController.swift
//  Refrii
//
//  Created by The book on 15/12/2018.
//  Copyright © 2018 The book. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    
    var itemArray = [ItemModel]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        print(dataFilePath)
        
        let newItem = ItemModel()
        newItem.itemName = "Lemon"
        itemArray.append(newItem)
        
        
//        if let items = defaults.array(forKey: "ItemArray") as? [String] {
//            itemArray = items
//        }
        
    }

    //MARK: - TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.itemName
        
        //Tenary Operator ==>
        // value = conditino ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
     
        let alert = UIAlertController(title:"Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Action", style: .default) { (action) in
        
            
            let newItem = ItemModel()
            newItem.itemName = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
           
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding itemes \(error)")
        }
        
     tableView.reloadData()
    }
    
    
}

