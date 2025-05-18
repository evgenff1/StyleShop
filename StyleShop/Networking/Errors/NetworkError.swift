//
//  NetworkError.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 23.03.2025.
//

import Foundation

// MARK: - NetworkError

/// Ошибки, связанные с сетью и работой API
enum NetworkError: Error, LocalizedError {
    /// Некорректный URL
    case badURL
    /// Невалидный ответ от сервера
    case invalidResponse
    /// Ошибка при декодировании ответа
    case decodingFailed
    /// Ошибка сервера с сообщением
    case serverError(String)
    /// Описание ошибки для отображения пользователю
    var errorDescription: String? {
        switch self {
        case .badURL:
            return Constants.NetworkError.badURL
        case .invalidResponse:
            return Constants.NetworkError.invalidResponse
        case .decodingFailed:
            return Constants.NetworkError.decodingFailed
        case .serverError(let message):
            return Constants.NetworkError.serverError + "\(message)"
        }
    }
}
