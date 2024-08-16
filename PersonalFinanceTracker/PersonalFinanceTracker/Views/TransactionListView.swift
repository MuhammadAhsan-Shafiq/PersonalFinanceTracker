import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @State private var showAddTransactionView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("\(transaction.category) • \(transaction.date, formatter: transactionDateFormatter)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(transaction.amount.formattedCurrency())
                                .font(.headline)
                                .foregroundColor(transaction.type == .income ? .green : .red)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color(.systemGroupedBackground))
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTransactionView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .sheet(isPresented: $showAddTransactionView){
            AddTransactionView(viewModel: viewModel)
        }
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
