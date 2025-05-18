//
//  StyleShopApp.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import SwiftUI

@main
struct StyleShopApp: App {
    
    // MARK: - View Models
    
    /// ViewModel для работы с товарами
    @StateObject private var productVM = ProductViewModel()
    /// ViewModel для работы с категориями
    @StateObject private var categoryVM = CategoryViewModel()
    /// ViewModel для управления корзиной
    @StateObject private var cartVM = CartViewModel()
    /// ViewModel для управления избранным
    @StateObject private var favoritesVM = FavoritesViewModel()
    /// ViewModel для поиска товаров
    @StateObject private var searchVM = SearchViewModel()
    /// ViewModel для нижней панели навигации
    @StateObject private var tabVM = TabViewModel()
    /// ViewModel для управления сессией пользователя
    @StateObject private var sessionVM = SessionViewModel()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            AuthWrapperView()
                .environmentObject(productVM)
                .environmentObject(categoryVM)
                .environmentObject(cartVM)
                .environmentObject(favoritesVM)
                .environmentObject(searchVM)
                .environmentObject(tabVM)
                .environmentObject(sessionVM)
        }
    }
}
