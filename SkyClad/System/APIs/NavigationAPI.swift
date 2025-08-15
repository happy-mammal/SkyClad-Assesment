//
//  NavigationAPI.swift
//  SkyClad
//
//  Created by Yash Lalit on 14/08/25.
//

import Foundation

protocol TabBarItem: Identifiable, Equatable, Hashable, CaseIterable {
    var title: String { get }
    var icon: String { get }
}

enum HomePageTabBarItem: TabBarItem {

    case analytics
    case exchange
    case record
    case wallet
    
    var title: String {
        switch self {
        case .analytics:
            return "Analytics"
        case .exchange:
            return "Exchange"
        case .record:
            return "Record"
        case .wallet:
            return "Wallet"
        }
    }
    
    var icon: String {
        switch self {
        case .analytics:
            return "chart.xyaxis.line"
        case .exchange:
            return "arrow.trianglehead.2.counterclockwise"
        case .record:
            return "list.bullet.rectangle.portrait"
        case .wallet:
            return "wallet.bifold"
        }
    }
    
    var id: Int {
        switch self {
        case .analytics:
            return 0
        case .exchange:
            return 1
        case .record:
            return 2
        case .wallet:
            return 3
        }
    }
    
    var shouldShowTabBar: Bool {
        switch self {
        case .exchange:
            return false
        default:
            return true
        }
    }
    
    var topBarTitle: String? {
        switch self {
        case .exchange:
            return self.title
        default:
            return nil
        }
    }
    
    var topBarLeadingIcon: String {
        switch self {
        case .exchange:
            return "chevron.left"
        default:
            return "line.3.horizontal"
        }
    }
    
    var topBarTrailingIcon: String? {
        switch self {
        case .exchange:
            return nil
        default:
            return "bell"
        }
    }
}
