//
//  ToDoTableViewCell.swift
//  HoneyDo
//
//  Created by Isiah Parra on 5/20/22.
//

import UIKit
protocol ToDoTablewViewCellDelegate: AnyObject {
    func didToggleIsComplete(_ todo: ToDo)
}

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    var toDo: ToDo? = nil
    weak var delegate: ToDoTablewViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCell(with todo: ToDo, withDelegate delegate: ToDoTablewViewCellDelegate) {
        self.delegate = delegate
        self.toDo = todo
        self.nameLabel.text = todo.name
        let buttonImage = todo.isComplete ? UIImage(systemName: "checkmark.rectangle.fill") :
        UIImage(systemName: "checkmark.rectangle")
        self.isCompleteButton.setImage(buttonImage, for: .normal)
        
    }
    @IBAction func didTapIsComplete(_ sender: UIButton) {
        guard let toDo = toDo else {return}
        delegate?.didToggleIsComplete(toDo)
    }
    
}

//MARK: ToDoTableViewCellDelegate
extension HomeTableViewController: ToDoTablewViewCellDelegate {
    func didToggleIsComplete(_ todo: ToDo) {
        ToDoController.shared.update(todo)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
