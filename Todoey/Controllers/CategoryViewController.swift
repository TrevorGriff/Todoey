//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Trevor Griffiths on 7/6/19.
//  Copyright © 2019 Trevor Griffiths. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategories()
        
        tableView.separatorStyle = .none

    }
    
    //MARK:     TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return categories?.count ?? 1
   
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
            
        }
        
        
        
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
            newCategory.color = UIColor.randomFlat.hexValue()
            
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
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {

        if let categoryForDeletion = self.categories?[indexPath.row]{
            do {
                try self.realm.write{
                    self.realm.delete(categoryForDeletion)
                }
            }catch {
                    print("Error deleting category, \(error)")
            }
        }
    }
}
