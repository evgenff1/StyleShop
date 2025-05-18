//
//  URLBuilder.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 23.03.2025.
//

import Foundation

// MARK: - URLBuilder

/// Утилита для построения URL-адресов запросов
enum URLBuilder {
    /// URL по заданному пути и параметрам
    /// - Parameters:
    ///   - path: Путь запроса
    ///   - queryItems: Массив параметров запроса
    /// - Returns: Возвращает собранный URL, если удалось — иначе nil
    static func build(path: String, queryItems: [URLQueryItem] = []) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.API.scheme
        components.host = Constants.API.host
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        return components.url
    }
}
