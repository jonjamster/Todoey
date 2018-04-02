//
//  ViewController.swift
//  Todoey
//
//  Created by John on 01/04/2018.
//  Copyright © 2018 Rom and Ram. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    

    let dataFilePath = FileManager.default.urls(for: .documentDirectory,
    in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

      
        

        loadItems()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:  indexPath)
        
      
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
       
            
        return cell
        
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
       
        saveItems()
  
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addButtonPressed(_ sender: Any) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
     
            self.itemArray.append(newItem)
            
          self.saveItems()
            
            
            
        }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
               textField = alertTextField
                
           
        
        }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        
        
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        
        do{
            
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
            
        }
        
        
        self.tableView.reloadData()
        
        
    }
    

    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
    }
    
    
    
}

