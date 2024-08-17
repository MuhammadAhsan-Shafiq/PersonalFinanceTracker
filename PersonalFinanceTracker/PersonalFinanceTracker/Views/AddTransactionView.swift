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
    
    @State private var title: String
    @State private var amount: String
    @State private var category: String
    @State private var date: Date
    @State private var type: TransactionType
    
    
    init(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        if let transaction = viewModel.selectedTransaction {
            _title = State(initialValue: String(transaction.title))
            _amount = State(initialValue: String(transaction.amount))
            _category = State(initialValue: transaction.category)
            _date = State(initialValue: transaction.date)
            _type = State(initialValue: transaction.type)
        } else {
            _title = State(initialValue: "")
            _amount = State(initialValue: "")
            _category = State(initialValue: "")
            _date = State(initialValue: Date())
            _type = State(initialValue: .income)
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Amount")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Categor")){
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
            .navigationBarTitle(viewModel.selectedTransaction == nil ? "Add Transaction" : "Edit Transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel"){
                presentationMode.wrappedValue.dismiss()
            },trailing: Button("Save"){
                saveTransaction()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    private func saveTransaction(){
      guard let amount = Double(amount), !category.isEmpty else { return }
        
        let transaction = Transaction(id: viewModel.selectedTransaction?.id ?? UUID(), title: title, amount: amount, category: category, date: date, type: type)
        viewModel.addTransaction(transaction)
        viewModel.resetSelectedTransaction()

        presentationMode.wrappedValue.dismiss()
    }
}


#Preview {
    AddTransactionView(viewModel: TransactionViewModel())
}
