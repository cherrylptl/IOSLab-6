//
//  ViewController.swift
//  IOSLab6
//
//  Created by user238103 on 2/18/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var items: [String] = []
    
    //Use to save data locally
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var myTableView: UITableView!
    @IBAction func AddButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Write an Item"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if let newItem = textField?.text, !newItem.isEmpty {
                            self.items.append(newItem)
                            self.saveItems()
                            self.myTableView.reloadData()
                        }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak alert](_) in
            alert?.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        getItemsFromStorage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    //display items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    //remove items
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            saveItems()
            myTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    //delete button at left
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //save Item
    func saveItems() {
         userDefaults.set(items, forKey: "SavedItems")
     }
     
     func getItemsFromStorage() {
         if let savedItems = userDefaults.array(forKey: "SavedItems") as? [String] {
             items = savedItems
         } else {
             items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8"]
         }
     }
    
}

