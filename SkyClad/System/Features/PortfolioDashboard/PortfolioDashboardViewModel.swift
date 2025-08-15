//
//  PortfolioDashboardViewModel.swift
//  SkyClad
//
//  Created by Yash Lalit on 15/08/25.
//

import Foundation

struct Asset {
    let id = UUID()
    let currency: Currency
    let value: Double
    let delta: Float
}

class PortfolioDashboardViewModel: ObservableObject {
    
    @Published var assets: [Asset] = []
    @Published var recentTransactions: [Transaction] = []
    
    @Published var showPortfolioValueInCrypto: Bool = false
    
    let availableChartDurations: [String] =  ["1h","8h","1d","1w","1m","6m", "1y"]
    
    @Published var selectedPortfolioChartDuration: String = "1h"
    
    @Published var isFetchingMoreAssets: Bool = false
    
    @Published var isFetchingMoreTransactions: Bool = false
    
    
     var portfolioValue: String {
        let symbol: String
        
        if showPortfolioValueInCrypto {
            symbol = CryptoCurrency.btc.symbol ?? ""
        }else {
            symbol = FiatCurrency.inr.symbol ?? ""
        }
        
        return "\(symbol) 1,57,342.05"
    }
    
    init() {
        onLoad()
    }
    
    func onLoad() {
        assets = [
            .init(currency: CryptoCurrency.btc, value: 7562502.14, delta: 3.2),
            .init(currency: CryptoCurrency.eth, value: 2547108.14, delta: 5.8),
            .init(currency: CryptoCurrency.btc, value: 7562502.14, delta: 3.2),
            .init(currency: CryptoCurrency.eth, value: 2547108.14, delta: 5.8)
        ]
        
        recentTransactions = [
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.000321),
            .init(type: .send, date: .now, currency: CryptoCurrency.eth, amount: 0.000321),
            .init(type: .recieve, date: .now, currency: CryptoCurrency.eth, amount: 0.000321),
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.000321),
        ]
        
    }
    

}
