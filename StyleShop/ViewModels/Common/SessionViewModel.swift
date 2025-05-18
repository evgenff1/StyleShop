//
//  SessionViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import Foundation

/// ViewModel для управления пользовательской сессией, включая авторизацию и регистрацию
@MainActor
final class SessionViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Флаг, был ли показан экран авторизации
    @Published var hasSeenAuth: Bool
    /// Флаг, указывающий, авторизован ли пользователь
    @Published var isAuthenticated: Bool
    /// Информация о текущем пользователе
    @Published var user: User?
    /// Токен авторизации текущей сессии
    @Published var token: String?
    
    // MARK: - Private Properties
    
    /// Сервис авторизации, реализующий бизнес-логику входа и регистрации
    private let authService = AuthService()
    /// Хранилище данных пользователя UserDefaults
    private let defaults = UserDefaults.standard
    
    // MARK: - Initialization
    
    /// Инициализация состояния пользовательской сессии
    /// Загружается значение из UserDefaults, если пользователь уже авторизован
    init() {
        self.hasSeenAuth = defaults.bool(forKey: Constants.Keys.hasSeenAuth)
        self.isAuthenticated = defaults.bool(forKey: Constants.Keys.isAuthenticated)

        if isAuthenticated {
            self.token = defaults.string(forKey: Constants.Keys.authToken)
            if let savedUserData = defaults.data(forKey: Constants.Keys.currentUser),
               let savedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
                self.user = savedUser
            }
        } else {
            defaults.removeObject(forKey: Constants.Keys.authToken)
            defaults.removeObject(forKey: Constants.Keys.currentUser)
        }
    }
    
    // MARK: - Public Methods
    
    /// Если экран авторизации был показан
    func markAuthSeen() {
        hasSeenAuth = true
        defaults.set(true, forKey: Constants.Keys.hasSeenAuth)
    }
    
    /// Авторизация пользователя по имени и паролю
    /// - Parameters:
    ///   - username: Имя пользователя
    ///   - password: Пароль
    /// - Returns: true, если авторизация прошла успешно
    func login(username: String, password: String) async -> Bool {
        do {
            let token = try await authService.login(username: username, password: password)
            self.token = token
            defaults.set(token, forKey: Constants.Keys.authToken)
            
            if let user = try await authService.getUser(byUsername: username) {
                self.user = user
                saveUserToDefaults(user)
                isAuthenticated = true
                defaults.set(true, forKey: Constants.Keys.isAuthenticated)
                markAuthSeen()
                return true
            }
        } catch {
            print("Login error:", error)
        }
        return false
    }
    
    /// Регистрирация нового пользователя
    /// - Parameters:
    ///   - email: Адрес электронной почты
    ///   - username: Имя пользователя
    ///   - password: Пароль
    ///   - firstname: Имя
    ///   - lastname: Фамилия
    /// - Returns: true, если регистрация прошла успешно
    func register(email: String, username: String, password: String, firstname: String, lastname: String) async -> Bool {
        do {
            let newId = try await authService.register(
                email: email,
                username: username,
                password: password,
                firstname: firstname,
                lastname: lastname
            )
            
            let user = try await authService.getUser(byId: newId)
            self.user = user
            saveUserToDefaults(user)
            isAuthenticated = true
            defaults.set(true, forKey: Constants.Keys.isAuthenticated)
            markAuthSeen()
            return true
        } catch {
            print("Register error:", error)
        }
        return false
    }
    
    /// Продолжить без регистрации
    func continueAsGuest() {
        user = nil
        token = nil
        isAuthenticated = true
        defaults.set(true, forKey: Constants.Keys.isAuthenticated)
        markAuthSeen()
    }
    
    /// Выйти из аккаунта
    func logout() {
        user = nil
        token = nil
        isAuthenticated = false
        defaults.removeObject(forKey: Constants.Keys.authToken)
        defaults.removeObject(forKey: Constants.Keys.currentUser)
        defaults.removeObject(forKey: Constants.Keys.isAuthenticated)
    }
    
    // MARK: - Private Methods
    
    /// Сохраняется объект пользователя в UserDefaults
    /// - Parameter user: Пользователь для сохранения
    private func saveUserToDefaults(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            defaults.set(data, forKey: Constants.Keys.currentUser)
        }
    }
}
