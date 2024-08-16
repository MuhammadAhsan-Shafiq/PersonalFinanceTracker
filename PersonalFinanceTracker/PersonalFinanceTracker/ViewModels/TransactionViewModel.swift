//
//  TransactionViewModel.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//

import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    init(){
        // Initialize with some dummy data for now
        transactions = [
            Transaction(title: "Salary", amount: 5000, category: "Income", date: Date(), type: .income),
            Transaction(title: "Rent", amount: -1500, category: "Housing", date: Date(), type: .expense),
            Transaction(title: "Groceries", amount: -300, category: "Food", date: Date(), type: .expense)
        ]
    }
    // Functions to add, delete, and update transactions will go here
}
