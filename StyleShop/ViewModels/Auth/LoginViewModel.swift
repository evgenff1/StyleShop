//
//  LoginViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

// MARK: - LoginViewModel

/// ViewModel для экрана входа в систему
@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Введённое имя пользователя
    @Published var username = ""
    /// Введённый пароль
    @Published var password = ""
    /// Показывать ли ошибку
    @Published var showError = false
    /// Сообщение об ошибке для отображения
    @Published var errorMessage = ""
    
    // MARK: - Dependencies

    /// ViewModel для управления сессией пользователя
    let session: SessionViewModel
    
    // MARK: - Initialization

    /// Инициализирует ViewModel с объектом SessionViewModel
    /// - Parameter session: Объект SessionViewModel, управляющий сессией
    init(session: SessionViewModel) {
        self.session = session
    }
    
    // MARK: - Actions

    /// Вход пользователя, если вход неудачен, отображается сообщение об ошибке
    func login() async {
        showError = false
        let success = await session.login(username: username, password: password)
        if !success {
            errorMessage = Constants.Text.Auth.loginErrorMessage
            showError = true
        }
    }

    /// Продолжить без входа в систему
    func continueAsGuest() {
        session.continueAsGuest()
    }
}
