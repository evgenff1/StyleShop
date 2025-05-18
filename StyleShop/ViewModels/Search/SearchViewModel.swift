//
//  SearchViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

/// ViewModel для обработки логики поиска продуктов
@MainActor
final class SearchViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Текущий поисковый запрос, введённый пользователем
    @Published var searchQuery: String = ""
    
    // MARK: - Search Logic
    
    /// Фильтрация списка продуктов по поисковому запросу и категории
    /// - Parameters:
    ///   - products: Список всех продуктов
    ///   - category: Текущая выбранная категория
    /// - Returns: Список продуктов, соответствующих фильтру
    func filteredProducts(_ products: [Product], category: String) -> [Product] {
        let byCategory = category == Constants.Text.Category.all
            ? products
            : products.filter { $0.category == category }

        guard !searchQuery.isEmpty else {
            return byCategory
        }

        let query = searchQuery.lowercased()
        return byCategory.filter { $0.title.lowercased().contains(query) }
    }
}
