//
//  HomeViewModel.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var selectedTabItem: HomePageTabBarItem =  .analytics
    
    var topBarLeadingIcon: String {
        selectedTabItem.topBarLeadingIcon
    }
    
    func onLeadingIconPressed() {
        
        if case .exchange = selectedTabItem {
            selectedTabItem = .analytics
        }
    }
}
