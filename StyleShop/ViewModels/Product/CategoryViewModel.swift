//
//  CategoryViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import SwiftUI

/// ViewModel для управления категориями продуктов
@MainActor
final class CategoryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Список всех категорий
    @Published var categories: [String] = [Constants.Text.Category.all]
    /// Выбранная пользователем категория
    @Published var selectedCategory: String = Constants.Text.Category.all
    
    // MARK: - Dependencies
    
    /// Сервис для получения списка категорий
    private let categoryService: CategoryServiceProtocol
    
    // MARK: - Initialization
    
    /// Инициализация с внедрением зависимости categoryService
    init(categoryService: CategoryServiceProtocol = CategoryService()) {
        self.categoryService = categoryService
        Task { await loadCategories() }
    }
    
    // MARK: - Data Loading
    
    /// Загружается список категорий продуктов
    func loadCategories() async {
        do {
            let fetched = try await categoryService.fetchCategories()
            categories = [Constants.Text.Category.all] + fetched.sorted()
        } catch {
            print("Ошибка загрузки категорий: \(error)")
        }
    }
    
    /// Устанавливается текущая выбранная категорию
    /// - Parameter category: Название категории
    func selectCategory(_ category: String) {
        selectedCategory = category
    }
}
