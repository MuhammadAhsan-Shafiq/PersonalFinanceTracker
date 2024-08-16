import SwiftUI

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @State private var showAddTransactionView = false
    @State private var selectedCategory: String = "All"
    @State private var selectedType: TransactionType = .all
    @State private var sortByDate = true

    var body: some View {
        NavigationView {
            VStack {
                // Filtering Options
                HStack {
                    Picker("Category", selection: $selectedCategory) {
                        Text("All").tag("All")
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Type", selection: $selectedType) {
                        Text("All").tag(TransactionType.all)
                        Text("Income").tag(TransactionType.income)
                        Text("Expense").tag(TransactionType.expense)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()

                // Sorting Options
                HStack {
                    Text("Sort by:")
                    Button(action: {
                        sortByDate.toggle()
                    }) {
                        Text(sortByDate ? "Date" : "Amount")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.horizontal)

                List {
                    ForEach(filteredAndSortedTransactions) { transaction in
                        NavigationLink(destination: TransactionDetailView(transaction: transaction)) {
                            TransactionRow(transaction: transaction)
                        }
                    }
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
        .sheet(isPresented: $showAddTransactionView) {
            AddTransactionView(viewModel: viewModel)
        }
    }

    private var filteredAndSortedTransactions: [Transaction] {
        var transactions = viewModel.transactions
        
        if selectedCategory != "All" {
            transactions = transactions.filter { $0.category == selectedCategory }
        }
        
        if selectedType != .all {
            transactions = transactions.filter { $0.type == selectedType }
        }
        
        if sortByDate {
            transactions = transactions.sorted { $0.date > $1.date }
        } else {
            transactions = transactions.sorted { $0.amount > $1.amount }
        }
        
        return transactions
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
