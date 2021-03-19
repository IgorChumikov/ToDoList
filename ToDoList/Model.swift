//
//  Model.swift
//  ToDoList
//
//  Created by Игорь Чумиков on 18.03.2021.
//  Copyright © 2021 Игорь Чумиков. All rights reserved.
//

import Foundation

let loadOneToDoItems: [[String : Any]] =  [["Name": "Тут твои дела", "isCompleted": false]]

var toDoItems: [[String : Any]] {
    
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKay")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let arrayData = UserDefaults.standard.array(forKey: "ToDoDataKay") as? [[String : Any]] {
           return arrayData
        }else{
            return loadOneToDoItems
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name" : nameItem, "isCompleted": isCompleted])
}

func removeItem(at index: Int) {
    toDoItems.remove(at: index)
}

func changeState(at item: Int) -> Bool{
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    return toDoItems[item]["isCompleted"] as! Bool
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = toDoItems[fromIndex]
    toDoItems.remove(at: fromIndex)
    toDoItems.insert(from, at: toIndex)
}
