//
//  ExchangeView.swift
//  SkyClad
//
//  Created by Yash Lalit on 12/08/25.
//

import SwiftUI

struct ExchangeView: View {

    @StateObject private var vm = ExchangeViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack{
                
                exchangeContent
                
                exchangeButton
                
                exchangeInfo
                
                Spacer()
                
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
        .alert(
            "Alert",
            isPresented: $vm.showAlert,
            actions: {},
            message: { Text(vm.alertMessage ?? "Something went wrong") }
        )
        .background(Color(hex: "#08080A"))

    }
}

extension ExchangeView {
    
    private var exchangeContent: some View {
        ZStack(alignment: .center){
            VStack {
                
                SCExchangeCard(
                    currencies: vm.allowedCurrencies,
                    transactionType: .send,
                    currency: $vm.sendCurrency,
                    balance: vm.displaySendBalance,
                    amount: $vm.sendAmount,
                    onChange: { vm.refreshUI() },
                    isActive: vm.isSendAmountEntered,
                    onActiveStatus: {
                        vm.isSendAmountEntered = true
                    }
                )
                
                SCExchangeCard(
                    currencies: vm.allowedCurrencies,
                    transactionType: .recieve,
                    currency: $vm.receiveCurrency,
                    balance: vm.displayReceiveBalance,
                    amount: $vm.receiveAmount,
                    onChange: { vm.refreshUI()},
                    isActive: !vm.isSendAmountEntered,
                    onActiveStatus: {
                        vm.isSendAmountEntered = false
                    }
                )
            }
            
            Button {
                vm.switchSides()
            } label: {
                ZStack {
                    LinearGradient(
                        colors: [
                            Color(hex: "#151517"),
                            Color(hex: "#0D0C0D"),
                            
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    RoundedRectangle(cornerRadius: 12.scaledUniform())
                           .stroke(
                            Color(hex: "#000000").opacity(0.25),
                            lineWidth: 1
                           )
                           .blur(radius: 4)
                           .offset(x: 0, y: -4)
                           .mask(
                            RoundedRectangle(cornerRadius: 12.scaledUniform())
                           )
                       
                    RoundedRectangle(cornerRadius: 12.scaledUniform())
                           .stroke(
                            Color(hex: "#FFFFFF").opacity(0.4),
                            lineWidth: 1
                           )
                           .blur(radius: 8)
                           .offset(x: 0, y: -2)
                           .mask(
                            RoundedRectangle(cornerRadius: 12.scaledUniform())
                           )
                    
                      RoundedRectangle(cornerRadius: 8.scaledUniform())
                        .stroke(
                            Color(hex: "#FBFBFB").opacity(0.12),
                            lineWidth: 1
                        )
                        .frame(
                            width: 36.scaledUniform(),
                            height: 36.scaledUniform()
                        )
                        
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(hex: "#FFFFFF"))
                        .frame(
                            width: 20.scaledUniform(),
                            height: 20.scaledUniform()
                        )
                        
                    
                    
                }
                .frame(
                    width: 52.scaledUniform(),
                    height: 52.scaledUniform()
                )
                .clipShape(RoundedRectangle(cornerRadius: 12.scaledUniform()))
            }

           
        }
    }
    
    private var exchangeButton: some View {
        SCPillButton(
            title: "Exchange",
            font: .interDisplay(16, .semibold),
            scheme: .classic,
            width: 358.scaledUniform(),
            height: 52.scaledUniform(),
            onTap: {vm.performExchange() }
        )
        .padding(.vertical, 10.scaledUniform())
    }
    
    @ViewBuilder
    private var exchangeInfo: some View {
        exchangeInfoTile(name: "Rate", value: vm.displayRate)
        
        exchangeInfoTile(name: "Spread", value: vm.displaySpread)
        
        exchangeInfoTile(name: "Gas fee", value: vm.displayGasFee)
        
        exchangeInfoTile(name: "You will recieve", value: vm.displayReceiving)
    }
    
    private func exchangeInfoTile(name: String, value: String) -> some View {
        HStack{
            Text(name)
                .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.64))
                .font(SCFont.interDisplay(14, .regular).font)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(Color(hex: "#FCFCFA").opacity(0.8))
                .font(SCFont.interDisplay(14, .medium).font)
        }
        .padding(.top, 10.scaledUniform())
        .padding(.horizontal, 20.scaledUniform())
    }
}

#Preview {
    ExchangeView()
}
