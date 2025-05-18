//
//  MainTabView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// Главное таб меню приложения с четырьмя вкладками каталог, корзина, избранное, профиль
struct MainTabView: View {
    
    /// ViewModel для управления текущей выбранной вкладкой
    @EnvironmentObject private var tabVM: TabViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabVM.selectedTab) {
                
                // Вкладка каталога товаров
                ProductListView()
                    .tabItem {
                        Label(Constants.Text.MainTabs.catalog, systemImage: Constants.Images.System.catalog)
                    }
                    .tag(Constants.Tab.catalog)
                
                // Вкладка корзины
                CartView()
                    .tabItem {
                        Label(Constants.Text.MainTabs.cart, systemImage: Constants.Images.System.cart)
                    }
                    .tag(Constants.Tab.cart)
                
                // Вкладка избранных товаров
                FavoritesView()
                    .tabItem {
                        Label(Constants.Text.MainTabs.favorites, systemImage: Constants.Images.System.favorites)
                    }
                    .tag(Constants.Tab.favorites)
                
                // Вкладка профиля пользователя
                ProfileView()
                    .tabItem {
                        Label(Constants.Text.MainTabs.profile, systemImage: Constants.Images.System.profile)
                    }
                    .tag(Constants.Tab.profile)
            }
        }
    }
}
