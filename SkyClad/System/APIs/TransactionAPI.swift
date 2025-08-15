//
//  TransactionAPI.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import Foundation

enum TransactionType {
    case send
    case recieve
    case exchange
    
    var text: String {
        switch self {
        case .send:
            return "Sent"
        case .recieve:
            return "Recieve"
        case .exchange:
            return "Exchange"
        }
    }
    
    var icon: String {
        switch self {
        case .send:
            return "arrow.up"
        case .recieve:
            return "arrow.down"
        case .exchange:
            return "arrow.up.arrow.down"
        }
    }
}

protocol Currency {
    var name: String { get }
    var code: String { get }
    var symbol: String? { get }
    var image: String? { get }
    var type: CurrencyType { get }
}

enum CurrencyType {
    case crypto
    case fiat
}

enum CryptoCurrency: String, Currency {
    case btc
    case eth
    
    var name: String {
        switch self {
        case .btc:
            return "Bitcoin"
        case .eth:
            return "Ethereum"
        }
    }
    
    var code: String {
        self.rawValue.uppercased()
    }
    
    var symbol: String? {
        switch self {
        case .btc:
            return "₿"
        case .eth:
            return nil
        }
    }
    
    var image: String? {
        switch self {
        case .btc:
            return "Bitcoin"
        case .eth:
            return "Ethereum"
        }
    }
    
    var type: CurrencyType {
        .crypto
    }
    
    
}

enum FiatCurrency: String, Currency {
    
    
    case inr
    
    var name: String {
        switch self {
        case .inr:
            return "Indian Rupees"
        }
    }
    
    var code: String {
        self.rawValue.uppercased()
    }
    
    var symbol: String? {
        switch self {
        case .inr:
            return "₹"
        }
    }
    
    var image: String? {
        switch self {
        case .inr:
            return nil
        }
    }
    
    var type: CurrencyType {
        .fiat
    }
}

struct Transaction {
    let id = UUID()
    let type: TransactionType
    let date: Date
    let currency: Currency
    let amount: Double
}
