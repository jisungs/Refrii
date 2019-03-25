//
//  CategoryViewController.swift
//  Refrii
//
//  Created by The book on 21/12/2018.
//  Copyright © 2018 The book. All rights reserved.
//

import UIKit
import RealmSwift
import Floaty

class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        
        tableView.rowHeight = 80.0
        
        //Add to View flaoty button
       floatyButton()
        
    }

    //MARK: - TableView Datasource Methods
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func load(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
   // MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error delete categories \(error)")
            }
        }

    }
    
    
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Action", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func floatyButton(){
        //let floaty = Floaty()
        
        Floaty.global.button.addItem("add New Storage", icon:UIImage(named:"fridge.png")!, handler:{
            item in let alert = UIAlertController(title: "Add New Storage", message:"",preferredStyle:.alert)
            var textField = UITextField()
            
            let action = UIAlertAction(title: "Add New Action", style: .default) { (action) in
                
                let newCategory = Category()
                newCategory.name = textField.text!
                self.save(category: newCategory)
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Add New Category"
                textField = alertTextField
            }
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
        })
        
        Floaty.global.show()
        
    }
}// end of view controller

