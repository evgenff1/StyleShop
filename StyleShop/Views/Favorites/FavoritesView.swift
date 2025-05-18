//
//  FavoritesView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// Экран избранных товаров с возможностью удаления
struct FavoritesView: View {
    
    /// ViewModel, содержащий список избранных товаров
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    /// ViewModel с общим списком всех товаров
    @EnvironmentObject private var productVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            // Список избранных товаров
            List(favoritesVM.favoriteProducts(from: productVM.products), id: \.id) { product in
                ProductRowWithNavigation(product: product)
                    .swipeActions {
                        // Действие удаления из избранного
                        Button(role: .destructive) {
                            favoritesVM.toggleFavorite(product.id)
                        } label: {
                            Label(Constants.Text.Favorites.removeAction, systemImage: Constants.Images.System.trash)
                        }
                    }
            }
            .listStyle(.plain)
            .navigationTitle(Constants.Text.MainTabs.favorites)
        }
    }
}
