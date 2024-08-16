//
//  TransactionDetailView.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//

import SwiftUI

struct TransactionDetailView: View {
    @State private var isEditing: Bool = false
    @State  var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            if isEditing{
                TextField("Title", text: $transaction.title)
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                
                TextField("Category", text: $transaction.category)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                DatePicker("Date", selection: $transaction.date, displayedComponents: .date)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                TextField("Amount", value: $transaction.amount, format: .currency(code: "USD"))
                    .font(.title2)
                    .keyboardType(.decimalPad)
                    .foregroundColor(transaction.type == .income ? .green : .red)
                
            } else {
                Text(transaction.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Category : \(transaction.category)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("Date: \(transaction.date, formatter: transactionDateFormatter)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("Amount: \(transaction.amount.formattedCurrency())")
                    .font(.title2)
                    .foregroundColor(transaction.type == .income ? .green : .red)
                
                Spacer()
                
                Button(action: {
                    if isEditing {
                        // Save the transaction here
                        // Call your ViewModel to update the transaction
                        isEditing.toggle()
                    }
                }, label: {
                    Text(isEditing ? "Save" : "Edit")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        .padding()
        .navigationTitle("Transaction Details")
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction(id: UUID(), title: "Sample Transaction", amount: 150.0, category: "Groceries", date: Date(),type: .expense))
}
