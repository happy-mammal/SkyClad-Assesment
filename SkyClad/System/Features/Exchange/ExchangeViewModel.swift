import Foundation
import Combine


// MARK: - ViewModel
final class ExchangeViewModel: ObservableObject {
    private let service = ExchangeService()
    
    let allowedCurrencies: [Currency] = [CryptoCurrency.btc, CryptoCurrency.eth, FiatCurrency.inr]
    @Published var sendAmount: String = "0.0"
    
    @Published var receiveAmount: String = "0.0"
    
    @Published var sendCurrency: Currency {
        didSet {
            refreshUI()
        }
    }
    
    @Published var receiveCurrency: Currency {
        didSet {
            refreshUI()
        }
    }
    
    @Published var displaySendBalance: Double = 0.0
    @Published var displayReceiveBalance: Double = 0.0
    @Published var displayRate: String = ""
    @Published var displaySpread: String = ""
    @Published var displayGasFee: String = ""
    @Published var displayReceiving: String = ""
    
    @Published var isSendAmountEntered: Bool = true
    
    // Alert properties
    @Published var alertMessage: String?
    @Published var showAlert: Bool = false
    
    init() {
        sendCurrency = CryptoCurrency.btc
        receiveCurrency = FiatCurrency.inr
        refreshUI()
    }
    
    func refreshUI() {
        displaySendBalance = service.balances[sendCurrency.code] ?? 0
        displayReceiveBalance = service.balances[receiveCurrency.code] ?? 0
        
        if let rate = service.getRate(from: sendCurrency.code, to: receiveCurrency.code) {
            displayRate = "1 \(sendCurrency.code) = \(format(rate)) \(receiveCurrency.code)"
        } else {
            displayRate = ""
        }
        
        if let spread = service.getSpread(from: sendCurrency.code, to: receiveCurrency.code) {
            displaySpread = "\(spread)%"
        } else {
            displaySpread = ""
        }
        
        displayGasFee = format(service.getGasFee(for: sendCurrency.code))
        if isSendAmountEntered {
            updateReceiving()
        }else {
            updateSending()
        }
    }
    
    func updateReceiving() {
        guard let amount = Double(sendAmount),
              let result = service.convert(amount: amount, from: sendCurrency, to: receiveCurrency) else {
            displayReceiving = ""
            receiveAmount = ""
            return
        }
        
        displayReceiving = "\(receiveCurrency.symbol ?? "") \(format(result))"
        receiveAmount = format(result)
    }
    
    func updateSending() {
        guard let amount = Double(receiveAmount),
              let rate = service.getRate(from: receiveCurrency.code, to: sendCurrency.code),
              let spread = service.getSpread(from: receiveCurrency.code, to: sendCurrency.code) else {
            sendAmount = ""
            return
        }
        
        // Reverse calculation: remove spread, gas if needed
        var result = amount * rate
        result -= result * (spread / 100.0)
        
        if receiveCurrency.type == .crypto {
            // Deduct gas fee in target units
            let gasFeeInTarget = service.getGasFee(for: receiveCurrency.code) * rate
            result -= gasFeeInTarget
        }
        displayReceiving = "\(receiveCurrency.symbol ?? "") \(format(result))"
        sendAmount = format(max(0, result))
    }

    
    func performExchange() {
        print("SEND | \(sendAmount)")
        guard let amount = Double(sendAmount) else { return }
        
        do {
            let received = try service.exchange(amount: amount, from: sendCurrency, to: receiveCurrency)
            receiveAmount = format(received)
            refreshUI()
            print("EXCEHANED")
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    private func format(_ value: Double) -> String {
        String(format: "%.4f", value)
    }
    
    func switchSides() {
        // Swap amounts
        let tempAmount = sendAmount
        sendAmount = receiveAmount
        receiveAmount = tempAmount
        
        // Swap currencies
        let tempCurrency = sendCurrency
        sendCurrency = receiveCurrency
        receiveCurrency = tempCurrency
        
        // Refresh all display properties in one go
        refreshUI()
    }

}
