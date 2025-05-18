//
//  ProductService.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import Foundation

// MARK: - ProductServiceProtocol

/// Протокол сервиса для получения товаров
protocol ProductServiceProtocol {
    /// Загрузка списка всех товаров
    /// - Returns: Массив объектов Product
    func fetchProducts() async throws -> [Product]
}

// MARK: - ProductService

final class ProductService: ProductServiceProtocol {
    /// Загружка списка всех товаров с сервера
    /// - Returns: Массив объектов Product
    /// - Throws: NetworkError, если URL некорректен, ответ невалиден или не удалось декодировать данные
    func fetchProducts() async throws -> [Product] {
        guard let url = URLBuilder.build(path: Constants.API.Paths.products) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
