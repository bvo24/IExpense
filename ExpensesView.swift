//
//  ExpensesView.swift
//  IExpense
//
//  Created by Brian Vo on 5/14/24.
//
import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List{
            ForEach(expenses, id: \.self){
            item in
                HStack{
                    VStack{
                        Text(item.name)
                        Text(item.type)
                        
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(item.amount >= 100 ? . red : item.amount < 100 && item.amount > 10 ? .yellow : .green   )
                }
                .accessibilityElement()
                .accessibilityLabel("\(item.name), \(item.type) expense, \(item.amount)")
                
                
            }
            .onDelete(perform: deleteItem)
            
        }
        
        
    }
    func deleteItem(at offsets : IndexSet){
        for offset in offsets{
            
            let item = expenses[offset]
            modelContext.delete(item)
            
            
            
        }
        
        
    }
    
    init(typeOfExpense: String , sortOrder : [SortDescriptor<Expense>]){
        
        _expenses = Query(filter: #Predicate<Expense>{item in item.type == typeOfExpense} ,sort: sortOrder)
        
        
        
    }
}

#Preview {
    
    ExpensesView( typeOfExpense: "Business" ,sortOrder: [SortDescriptor(\Expense.amount)])
}
