//
//  Transition.swift
//  PersonalFinanceTracker
//
//  Created by MacBook Pro on 16/08/2024.
//

import Foundation

struct Transaction: Identifiable {
    var id = UUID()
    var title : String
    var amount: Double
    var category: String
    var date: Date
    var type: TransactionType
}

enum TransactionType: String, CaseIterable, Identifiable {
    case all = "All"
    case income = "Income"
    case expense = "Expence"
    
    var id: String { self.rawValue }
}
