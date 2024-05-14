//
//  Expense.swift
//  IExpense
//
//  Created by Brian Vo on 5/14/24.
//

import Foundation
import SwiftData

@Model
class Expense{
    let name : String
    let type : String
    let amount : Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
    
}
