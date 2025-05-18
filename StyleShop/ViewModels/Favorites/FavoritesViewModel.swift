//
//  FavoritesViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// ViewModel для управления избранными товарами
@MainActor
final class FavoritesViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Множество идентификаторов избранных товаров
    @Published var favorites: Set<Int> = []
    
    // MARK: - Favorite Management
    
    /// Переключает состояние избранное у товара
    /// - Parameter id: Идентификатор товара
    func toggleFavorite(_ id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
    
    /// Возвращается список избранных товаров
    /// - Parameter products: Список всех доступных товаров
    /// - Returns: Массив товаров, добавленных в избранное
    func favoriteProducts(from products: [Product]) -> [Product] {
        products.filter { favorites.contains($0.id) }
    }
    
    /// Проверяется, добавлен ли товар в избранное
    /// - Parameter id: Идентификатор товара
    /// - Returns: true, если товар в избранном, иначе false
    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(id)
    }
}
