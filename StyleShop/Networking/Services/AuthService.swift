//
//  AuthService.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import Foundation

// MARK: - AuthService

/// Сервис для работы с API авторизации и пользователей
final class AuthService {
    
    // MARK: — Login
    
    /// Запрос на авторизацию, возвращается токен
    /// - Parameters:
    ///   - username: имя пользователя
    ///   - password: пароль
    /// - Returns: токен авторизации
    /// - Throws: NetworkError в случае сетевой или декодирования ошибки
    func login(username: String, password: String) async throws -> String {
        guard let url = URLBuilder.build(path: Constants.API.Paths.authLogin) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Network.HTTPMethod.post
        request.setValue(Constants.Network.HeaderValue.applicationJSON, forHTTPHeaderField: Constants.Network.HeaderField.contentType)
        request.httpBody = try JSONEncoder().encode([
            Constants.Network.JSONKeys.username: username,
            Constants.Network.JSONKeys.password: password
        ])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResp = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResp.statusCode == 200 else {
            let message = String(data: data, encoding: .utf8)
            throw NetworkError.serverError(message ?? Constants.Text.Auth.unknownServerError)
        }
        
        do {
            return try JSONDecoder().decode(TokenResponse.self, from: data).token
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    // MARK: — Register
    
    /// Регистрация нового пользователя в API и возвращение его id
    /// - Parameters:
    ///   - email: электронная почта
    ///   - username: имя пользователя
    ///   - password: пароль
    ///   - firstname: имя
    ///   - lastname: фамилия
    /// - Returns: id вновь созданного пользователя
    /// - Throws: NetworkError при ошибках сети или декодирования
    func register(
        email: String,
        username: String,
        password: String,
        firstname: String,
        lastname: String
    ) async throws -> Int {
        guard let url = URLBuilder.build(path: Constants.API.Paths.users) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Network.HTTPMethod.post
        request.setValue(Constants.Network.HeaderValue.applicationJSON, forHTTPHeaderField: Constants.Network.HeaderField.contentType)
        
        let body: [String: Any] = [
            Constants.Network.JSONKeys.email: email,
            Constants.Network.JSONKeys.username: username,
            Constants.Network.JSONKeys.password: password,
            Constants.Network.JSONKeys.name: [
                Constants.Network.JSONKeys.firstname: firstname,
                Constants.Network.JSONKeys.lastname: lastname
            ]
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResp = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200..<300).contains(httpResp.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw NetworkError.serverError(message ?? Constants.Text.Auth.unknownServerError)
        }
        
        do {
            return try JSONDecoder().decode(RegisterResponse.self, from: data).id
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    // MARK: — Get User by ID
    
    /// Получение информации о пользователе по его id
    /// - Parameter id: идентификатор пользователя
    /// - Returns: модель User
    /// - Throws: NetworkError при ошибках сети или декодирования
    func getUser(byId id: Int) async throws -> User {
        guard let url = URLBuilder.build(path: Constants.API.Paths.userById + "\(id)") else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    // MARK: — Get User by Username
    
    /// Получение информации о пользователях и выбор первого с username
    /// - Parameter username: имя пользователя
    /// - Returns: модель User, если найдена, иначе nil
    /// - Throws: `NetworkError` при ошибках сети или декодирования
    func getUser(byUsername username: String) async throws -> User? {
        guard let url = URLBuilder.build(path: Constants.API.Paths.users) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let users = try JSONDecoder().decode([User].self, from: data)
        return users.first { $0.username == username }
    }
    
    // MARK: - Response Types
    
    /// Ответ от сервера при авторизации пользователя
    private struct TokenResponse: Decodable {
        /// Токен доступа
        let token: String
    }
    
    /// Ответ от сервера после регистрации пользователя
    private struct RegisterResponse: Codable {
        /// Уникальный идентификатор зарегистрированного пользователя
        let id: Int
    }
}
