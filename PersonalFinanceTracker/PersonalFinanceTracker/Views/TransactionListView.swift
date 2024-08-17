
import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.transactions.indices, id: \.self) { index in
                    NavigationLink(destination: TransactionDetailView(transaction: viewModel.transactions[index], viewModel: viewModel)) {
                        TransactionRow(transaction: viewModel.transactions[index])
                    }
                    .contextMenu {
                        Button(action: {
                            viewModel.selectedTransaction = viewModel.transactions[index]
                            viewModel.showAddTransactionView = true
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        Button(action: {
                            viewModel.deleteTransaction(at: index)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.selectedTransaction = nil
                        viewModel.showAddTransactionView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddTransactionView) {
            AddTransactionView(viewModel: viewModel)
        }
    }
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(transaction.amount.formattedCurrency())
                .font(.headline)
                .foregroundColor(transaction.type == .income ? .green : .red)
        }
        .padding(.vertical, 5)
    }
}

// Extension to format amounts as currency
extension Double {
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()



#Preview{
    TransactionListView(viewModel: TransactionViewModel())
}
