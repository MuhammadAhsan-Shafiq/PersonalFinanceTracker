//
//  TransactionListView.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading){
                            Text(transaction.title)
                            
                            Text("\(transaction.category) • \(transaction.date, formatter: transactionDateFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(format: "%.2f", transaction.amount))
                            .font(.headline)
                            .foregroundColor(transaction.type == .income ? .green : .red)
                    }
                    .padding(.vertical, 5)
                }
                .navigationTitle("Transactions")
            }
        }
    }
}
let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
#Preview {
    TransactionListView(viewModel: TransactionViewModel())
}
