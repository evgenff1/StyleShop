//
//  CategoryService.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import Foundation

// MARK: - CategoryServiceProtocol

/// Протокол сервиса для получения категорий товаров
protocol CategoryServiceProtocol {
    /// Загрузка списка всех категорий товаров
    /// - Returns: Массив строк с названиями категорий
    func fetchCategories() async throws -> [String]
}

// MARK: - CategoryService

/// Сервис для получения списка категорий товаров
final class CategoryService: CategoryServiceProtocol {
    /// Загрузка списка всех категорий с сервера
    /// - Returns: Массив строк с названиями категорий
    /// - Throws: NetworkError, если URL некорректен, ответ невалиден или не удалось декодировать данные.
    func fetchCategories() async throws -> [String] {
        guard let url = URLBuilder.build(path: Constants.API.Paths.productCategories) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
