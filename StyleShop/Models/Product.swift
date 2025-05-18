//
//  Product.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import Foundation

// MARK: - Product Model

/// Модель товара
struct Product: Identifiable, Decodable {
    /// Уникальный идентификатор товара
    let id: Int
    /// Название товара
    let title: String
    /// Цена товара
    let price: Double
    /// Описание товара
    let description: String
    /// Категория товара
    let category: String
    /// URL изображение товара
    let image: String
    /// Рейтинг товара
    let rating: Rating
    /// Вложенная структура рейтинга
    struct Rating: Decodable {
        /// Средняя оценка
        let rate: Double
        /// Количество голосов
        let count: Int
    }
}
