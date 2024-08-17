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
    @Published var selectedTransaction: Transaction?
    @Published var showAddTransactionView: Bool = false
    
    
    func addTransaction(_ transaction: Transaction){
        if let selectedTransaction = selectedTransaction, let index = transactions.firstIndex(where: { $0.id == selectedTransaction.id}){
            //update existing transaction
            transactions[index] = transaction
        } else {
            //add new transaction
            transactions.append(transaction)
        }
    }
    func deleteTransaction(at index: Int) {
          transactions.remove(at: index)
      }
    
    func selectedTransaction(_ transaction: Transaction){
        selectedTransaction = transaction
    }
    func resetSelectedTransaction() {
        selectedTransaction = nil
    }
}
