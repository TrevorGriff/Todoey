//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Trevor Griffiths on 7/6/19.
//  Copyright © 2019 Trevor Griffiths. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()

    }
    
    //MARK:     TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return categories?.count ?? 1
   
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
        
    }
    //MARK:     Data Manipulation Methods
    //MARK:     Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            
            textField.placeholder = "Type new Category here"
            
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:     TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    
    //MARK:load/save methods on data for categories
    
   func  loadCategories(){
    
        categories = realm.objects(Category.self)

        tableView.reloadData()

   }
    
    func save(category: Category){
    
        do{
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving  Categories \(error)")
        }
        tableView.reloadData()
    }
  
}
