//
//  AddTransactionView.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TransactionViewModel
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var date: Date = Date()
    @State private var type: TransactionType = .expense
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    TextField("Category", text: $category)
                }
                
                Section(header: Text("Date")){
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Type")){
                    Picker("Type", selection: $type){
                        Text("Income").tag(TransactionType.income)
                        Text("Expense").tag(TransactionType.expense)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarItems(leading: Button("Cancel"){
                presentationMode.wrappedValue.dismiss()
            },trailing: Button("Save"){
                saveTransaction()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    private func saveTransaction(){
        guard let amount = Double(amount) else { return }
        let newTransaction = Transaction(title: title, amount: amount, category: category, date: date, type: type)
        viewModel.transactions.append(newTransaction)
        }
    }


#Preview {
    AddTransactionView(viewModel: TransactionViewModel())
}
