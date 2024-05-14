//
//  AddView.swift
//  IExpense
//
//  Created by Brian Vo on 5/2/24.
//

import SwiftUI

struct AddView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
//    var expenses : Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
            
        NavigationStack{
            Form{
                
                TextField("Name: ", text: $name)
                Picker("Type: ", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount: ", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.numberPad)
                
                
                
            }
            .navigationTitle("Add new expense")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let item = Expense(name: name, type: type, amount: amount)
                        modelContext.insert(item)
                        
                        //expenses.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
                
                
            }
            .navigationBarBackButtonHidden()
            
            
        }
        
        
        
        
        
        
        
    }
}

#Preview {
    AddView()
}
