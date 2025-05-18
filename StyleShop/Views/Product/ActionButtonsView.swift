//
//  ActionButtonsView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 18.03.2025.
//

import SwiftUI

/// Вспомогательное представление с кнопками действий для товара
/// добавить в избранное и в корзину
struct ActionButtonsView: View {
    
    /// ViewModel корзины
    @EnvironmentObject private var cartVM: CartViewModel
    /// ViewModel избранного
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    
    /// Товар, к которому применяются действия
    let product: Product
    
    var body: some View {
        VStack {
            // Кнопка избранного
            CircleIconButton(
                systemImage: favoritesVM.isFavorite(product.id)
                ? Constants.Images.System.heartFill
                : Constants.Images.System.heart,
                color: .red
            ) {
                // Переключает состояние избранное для товара
                favoritesVM.toggleFavorite(product.id)
            }
            
            Spacer()
            
            // Кнопка добавления в корзину
            CircleIconButton(
                systemImage: cartVM.cart[product.id] != nil
                ? Constants.Images.System.checkmark
                : Constants.Images.System.cartPlus,
                color: .green
            ) {
                // Добавляет товар в корзину
                cartVM.addToCart(product.id)
            }
        }
    }
}
