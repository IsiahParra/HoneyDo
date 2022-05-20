//
//  HomeTableViewController.swift
//  HoneyDo
//
//  Created by Isiah Parra on 5/20/22.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        presentAddScreen()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoController.shared.toDoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else {return UITableViewCell()}
       
        let todo = ToDoController.shared.toDoList[indexPath.row]
        cell.loadCell(with: todo, withDelegate: self)

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let toDo = ToDoController.shared.toDoList[indexPath.row]
            ToDoController.shared.delete(toDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //MARK: UIAlertController
    
    

}// End OF Class

extension HomeTableViewController {
    func presentAddScreen() {
        let alertController = UIAlertController(title: "Create Todo item", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "To do name..."
        }
        let createAction = UIAlertAction(title: "Create", style: .default) { [unowned alertController] _ in
            
            guard let newName = alertController.textFields?[0].text,
            !newName.isEmpty else {return}
            ToDoController.shared.create(name: newName)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(createAction)
        present(alertController, animated: true)
        }
}

