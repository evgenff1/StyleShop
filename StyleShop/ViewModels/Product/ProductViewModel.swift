//
//  ProductViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import SwiftUI

/// ViewModel для управления списком продуктов
@MainActor
final class ProductViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Список загруженных продуктов
    @Published var products: [Product] = []
    /// Флаг, указывающий на состояние загрузки
    @Published var isLoading = false
    
    // MARK: - Dependencies
    
    /// Сервис для получения данных о продуктах
    private let productService: ProductServiceProtocol
    
    // MARK: - Initialization
    
    /// Инициализация с внедрением зависимости productService
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
        Task { await loadProducts() }
    }
    
    // MARK: - Data Loading
    
    /// Загрузка списка продуктов с сервера
    func loadProducts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.products = try await productService.fetchProducts()
        } catch {
            print("Ошибка загрузки продуктов: \(error)")
        }
    }
    
    /// Возвращается продукт по заданному идентификатору
    /// - Parameter id: Идентификатор продукта
    /// - Returns: Объект Product, если найден, иначе nil
    func product(by id: Int) -> Product? {
        products.first { $0.id == id }
    }
}
