//
//  User.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import Foundation

// MARK: - User Model

/// Модель пользователя
struct User: Codable {
    /// Уникальный идентификатор пользователя
    let id: Int
    /// Электронная почта пользователя
    let email: String?
    /// Имя пользователя (логин)
    let username: String?
    /// Полное имя пользователя
    let name: Name?
    /// Вложенная структура с именем пользователя
    struct Name: Codable {
        /// Имя
        let firstname: String
        /// Фамилия
        let lastname: String
    }
}
