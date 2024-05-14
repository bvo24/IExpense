//
//  ContentView.swift
//  IExpense
//
//  Created by Brian Vo on 5/2/24.
//
import SwiftData
import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
    
}

//@Observable
//class Expenses{
//    var items = [ExpenseItem](){
//        didSet{
//            if let encoded = try? JSONEncoder().encode(items){
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//        
//    }
//    
//    init(){
//        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
//                items = decodedItems
//                return
//            }
//            
//        }
//        items = []
//    }
//    
//    var personalItems : [ExpenseItem]{
//        items.filter {$0.type == "Personal"}
//        
//    }
//    
//    var businessItems : [ExpenseItem]{
//        items.filter {$0.type == "Business"}
//        
//    }
//    
//    
//    
//    
//}

//struct addView : View{
//    
//    
//    var body: some View{
//        
//        
//        
//    }
//    
//}





struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    
    
    
    
//    @State private var expenses = Expenses()
    
    
    @Query(sort: [
        SortDescriptor(\Expense.amount), SortDescriptor(\Expense.name)])
    
    

    var expenses : [Expense]
    
    @State private var showingAddExpense = false
    
    @State private var title = "Name"
    
    @State private var showBusinessExpense = false
    
    
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    
    ]
    
    
    
    var body: some View {
        NavigationStack{
            
            ExpensesView(typeOfExpense: showBusinessExpense ? "Business" : "Personal" , sortOrder: sortOrder)
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                NavigationLink(destination: AddView()){
                    Image(systemName: "plus")
                }
                
                Button(showBusinessExpense ? "Show Personal" : "Show Business"  ){
                    showBusinessExpense.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Sort by price")
                        
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                    }
                    
                }
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $showingAddExpense){
                AddView()

            }
           
            
            
            
            
        }
        
        
        
//        NavigationStack{
//            
//            List{
//                
//                Section("Personal Costs"){
//                    ForEach(expenses.personalItems){item in
//                        HStack{
//                            VStack(alignment: .leading){
//                                Text(item.name)
//                                    .font(.headline)
//                                Text(item.type)
//                            }
//                            Spacer()
//                            
//                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
//                        }
//                        
//                    }
//                    .onDelete(perform: removePersonalItem)
//                }
//                Section("Business Costs"){
//                    ForEach(expenses.businessItems){item in
//                        HStack{
//                            VStack(alignment: .leading){
//                                Text(item.name)
//                                    .font(.headline)
//                                Text(item.type)
//                            }
//                            Spacer()
//                            
//                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                                .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
//                        }
//                        
//                    }
//                    .onDelete(perform: removeBusinessItem)
//                }
//            }
//            .navigationTitle($title)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                NavigationLink(destination: AddView(expenses: expenses)){
//                    Image(systemName: "plus")
//            }
//            }
            //.navigationBarBackButtonHidden()
//            .sheet(isPresented: $showingAddExpense){
//                AddView(expenses: expenses)
//                
//            }
//        }
    }
    
    func deleteItem(at offsets : IndexSet){
        for offset in offsets{
            
            let item = expenses[offset]
            modelContext.delete(item)
            
            
        }
        
        
    }
    
//    func removeItem(at offset : IndexSet){
//        expenses.items.remove(atOffsets: offset)
//        for item in expenses.items{
//            print(item)
//        }
//    }
//    
//    func removePersonalItem(at offsets : IndexSet){
//
//        
//        //Allows us to turn an IndexSet into a useable int
//        for offset in offsets {
//
//          //Here we look through the expsenses list and compare the ids to the one we wanted to delete in our filtered list
//            if let index = expenses.items.firstIndex(where: {$0.id == expenses.personalItems[offset].id}) {
//            // delete the item from the expenses.items array at the index you found its match
//              expenses.items.remove(at: index)
//
//            }
//          }
//        
//    }
//    func removeBusinessItem(at offsets : IndexSet){
//        
//        //Allows us to turn an IndexSet into a useable int
//        for offset in offsets {
//
//          //Here we look through the expsenses list and compare the ids to the one we wanted to delete in our filtered list
//            if let index = expenses.items.firstIndex(where: {$0.id == expenses.businessItems[offset].id}) {
//            // delete the item from the expenses.items array at the index you found its match
//              expenses.items.remove(at: index)
//
//            }
//          }
//        
//    }
//    
    
    
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
