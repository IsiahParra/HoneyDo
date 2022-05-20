//
//  ToDo.swift
//  HoneyDo
//
//  Created by Isiah Parra on 5/20/22.
//

import Foundation

class ToDoController {
    //MARK: PROPERTIES
    static let shared = ToDoController()
    var toDoList = [ToDo]()
    
    //MARK: CRUD
    
    func create(name: String, isComplete: Bool = false) {
        let newToDo = ToDo(name: name, isComplete: isComplete)
        toDoList.append(newToDo)
        saveToDisk()
    }
    func delete(_ toDo: ToDo) {
        guard let index = toDoList.firstIndex(of: toDo) else {return}
        toDoList.remove(at: index)
        saveToDisk()
    }
    
    func update(_ toDo: ToDo) {
        toDo.isComplete.toggle()
        saveToDisk()
    }
    
}// End of class

//MARK: Persistence
extension ToDoController {
    private var fileURL: URL? {
        guard let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {return nil}
        let url = documentDir.appendingPathComponent("HoneyDo.json")
        return url
    }
    //Save to Disk
    private func saveToDisk() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(self.toDoList)
            try data.write(to: url )
        } catch let error {
            print(error)
        }
    }
    //read from disk
    private func readFromDisk() {
        guard let url = fileURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let todoList = try JSONDecoder().decode([ToDo].self, from: data)
            self.toDoList = todoList
        } catch let error {
            print(error)
        }
    }
}
