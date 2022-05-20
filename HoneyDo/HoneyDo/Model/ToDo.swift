//
//  ToDo.swift
//  HoneyDo
//
//  Created by Isiah Parra on 5/20/22.
//

import Foundation

class ToDo: Codable {
    let name: String
    var isComplete: Bool
    let uuid: String
    
    init(name: String, isComplete: Bool = false, uuid: String = UUID().uuidString) {
    self.isComplete = isComplete
    self.name = name
    self.uuid = uuid
    }
}// End of Class

//MARK: Equatable
extension ToDo: Equatable {
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.name == rhs.name && lhs.isComplete == rhs.isComplete && lhs.uuid == rhs.uuid
    }
}
