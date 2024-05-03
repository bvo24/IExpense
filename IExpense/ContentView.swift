//
//  ContentView.swift
//  IExpense
//
//  Created by Brian Vo on 5/2/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
    
}

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
        
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
            
        }
        items = []
    }
    
    var personalItems : [ExpenseItem]{
        items.filter {$0.type == "Personal"}
        
    }
    
    var businessItems : [ExpenseItem]{
        items.filter {$0.type == "Business"}
        
    }
    
    
    
    
}






struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack{
            
            List{
                
                Section("Personal Costs"){
                    ForEach(expenses.personalItems){item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
                        }
                        
                    }
                    .onDelete(perform: removePersonalItem)
                }
                Section("Business Costs"){
                    ForEach(expenses.businessItems){item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
                        }
                        
                    }
                    .onDelete(perform: removeBusinessItem)
                }
            }
            .navigationTitle("IExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
                
            }
        }
    }
    
    func removeItem(at offset : IndexSet){
        expenses.items.remove(atOffsets: offset)
        for item in expenses.items{
            print(item)
        }
    }
    
    func removePersonalItem(at offsets : IndexSet){

        
        //Allows us to turn an IndexSet into a useable int
        for offset in offsets {

          //Here we look through the expsenses list and compare the ids to the one we wanted to delete in our filtered list
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
            // delete the item from the expenses.items array at the index you found its match
              expenses.items.remove(at: index)

            }
          }
        
    }
    func removeBusinessItem(at offsets : IndexSet){
        
        //Allows us to turn an IndexSet into a useable int
        for offset in offsets {

          //Here we look through the expsenses list and compare the ids to the one we wanted to delete in our filtered list
            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
            // delete the item from the expenses.items array at the index you found its match
              expenses.items.remove(at: index)

            }
          }
        
    }
    
    
    
}

#Preview {
    ContentView()
}




//                ForEach(expenses.items){item in
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text(item.name)
//                                .font(.headline)
//                            Text(item.type)
//
//
//                        }
//                        Spacer()
//
//                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
//                    }
