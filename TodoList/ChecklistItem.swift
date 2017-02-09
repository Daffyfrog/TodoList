//
//  ChecklistItem.swift
//  TodoList
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class ChecklistItem {
    var checked : Bool
    var text : String
    
    init(text:String, checked : Bool = false){
        self.text = text
        self.checked = checked
    }
    func toggleCheck(){
        self.checked = !self.checked
    }
}
