//
//  TransactionSummaryViewModel.swift
//  SkyClad
//
//  Created by Yash Lalit on 15/08/25.
//

import Foundation

class TransactionSummaryViewModel: ObservableObject {
    
    @Published var transactions:[Transaction] = []
    @Published var isFetching: Bool = false
    private var page: Int = 0
    
    init() {
        onLoad()
    }
    
    func onLoad() {
        transactions = [
            .init(type: .recieve, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .send, date: .now, currency: CryptoCurrency.eth, amount: 0.003126),
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .recieve, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .send, date: .now, currency: CryptoCurrency.eth, amount: 0.003126),
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
        ]
        page = 1
    }
    
    func onFetchMore() async {
        guard page < 3 else { return }
        
        isFetching = true
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        page += 1
        
        let data:[Transaction] = [
            .init(type: .recieve, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .send, date: .now, currency: CryptoCurrency.eth, amount: 0.003126),
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .recieve, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
            .init(type: .send, date: .now, currency: CryptoCurrency.eth, amount: 0.003126),
            .init(type: .send, date: .now, currency: CryptoCurrency.btc, amount: 0.002126),
        ]
        transactions.append(contentsOf: data)
        
        isFetching = false
        
        
    }
    
}
