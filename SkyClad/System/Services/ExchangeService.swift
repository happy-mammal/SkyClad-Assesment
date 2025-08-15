//
//  ExchangeService.swift
//  SkyClad
//
//  Created by Yash Lalit on 15/08/25.
//

import Foundation

// MARK: - Errors
enum ExchangeError: LocalizedError {
    case sameCurrencyNotAllowed
    case fiatToFiatNotAllowed
    case insufficientBalance(currency: String)
    case invalidPair
    case conversionFailed
    
    var errorDescription: String? {
        switch self {
        case .sameCurrencyNotAllowed:
            return "You cannot exchange the same currency."
        case .fiatToFiatNotAllowed:
            return "Direct fiat-to-fiat exchanges are not allowed."
        case .insufficientBalance(let c):
            return "Insufficient balance in \(c)."
        case .invalidPair:
            return "Invalid currency pair."
        case .conversionFailed:
            return "Unable to convert amount."
        }
    }
}

// MARK: - Service
final class ExchangeService {
    private(set) var balances: [String: Double] = [
        "BTC": 5.0,
        "ETH": 10.0,
        "USD": 2000.0,
        "INR": 150000.0
    ]
    
    // Dummy exchange rates
    private let rates: [String: [String: Double]] = [
        "BTC": ["ETH": 20.0, "USD": 64000.0, "INR": 64000.0 * 83.25],
        "ETH": ["BTC": 0.05, "USD": 3200.0, "INR": 3200.0 * 83.25],
        "USD": ["BTC": 1.0 / 64000.0, "ETH": 1.0 / 3200.0],
        "INR": ["BTC": 1.0 / (64000.0 * 83.25), "ETH": 1.0 / (3200.0 * 83.25)]
    ]
    
    // Spreads (percent)
    private let spreads: [String: [String: Double]] = [
        "BTC": ["ETH": 0.5, "USD": 0.7, "INR": 0.7],
        "ETH": ["BTC": 0.5, "USD": 0.7, "INR": 0.7],
        "USD": ["BTC": 0.5, "ETH": 0.5],
        "INR": ["BTC": 0.5, "ETH": 0.5]
    ]
    
    // Gas fees for crypto → deducted in source units
    private let gasFees: [String: Double] = [
        "BTC": 0.0005,
        "ETH": 0.005
    ]
    
    func validatePair(from: Currency, to: Currency) throws {
        if from.code == to.code { throw ExchangeError.sameCurrencyNotAllowed }
        if from.type == .fiat && to.type == .fiat { throw ExchangeError.fiatToFiatNotAllowed }
    }
    
    func getRate(from: String, to: String) -> Double? {
        rates[from]?[to]
    }
    
    func getSpread(from: String, to: String) -> Double? {
        spreads[from]?[to]
    }
    
    func getGasFee(for currency: String) -> Double {
        gasFees[currency] ?? 0.0
    }
    
    func convert(amount: Double, from: Currency, to: Currency) -> Double? {
        guard let rate = getRate(from: from.code, to: to.code),
              let spread = getSpread(from: from.code, to: to.code) else { return nil }
        
        var result = amount * rate
        result -= result * (spread / 100.0)
        
        if from.type == .crypto {
            // Deduct gas fee in target units
            let gasFeeInTarget = getGasFee(for: from.code) * rate
            result -= gasFeeInTarget
        }
        
        return max(0, result)
    }
    
    func exchange(amount: Double, from: Currency, to: Currency) throws -> Double {
        try validatePair(from: from, to: to)
        
        guard let balance = balances[from.code], balance >= amount else {
            throw ExchangeError.insufficientBalance(currency: from.code)
        }
        
        guard let received = convert(amount: amount, from: from, to: to) else {
            throw ExchangeError.conversionFailed
        }
        
        balances[from.code] = balance - amount
        balances[to.code] = (balances[to.code] ?? 0) + received
        
        return received
    }
}
