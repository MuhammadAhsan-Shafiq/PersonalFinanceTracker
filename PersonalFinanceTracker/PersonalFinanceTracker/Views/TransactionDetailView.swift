//
//  TransactionDetailView.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//
import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    @ObservedObject var viewModel: TransactionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Category: \(transaction.category)")
                .font(.headline)

            Text("Amount: \(String(format: "%.2f", transaction.amount))")
                .font(.body)

            Text("Date: \(transaction.date, formatter: transactionDateFormatter)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
        .padding()
        .navigationTitle("Transaction Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.selectedTransaction = transaction
                    viewModel.showAddTransactionView = true
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddTransactionView) {
            AddTransactionView(viewModel: viewModel)
        }
    }
}


#Preview {
    TransactionDetailView(transaction: Transaction(id: UUID(), title: "Sample Transaction", amount: 150.0, category: "Groceries", date: Date(),type: .expense), viewModel: TransactionViewModel())
}
