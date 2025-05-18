//
//  RegisterViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

// MARK: - RegisterViewModel

/// ViewModel для экрана регистрации нового пользователя
@MainActor
final class RegisterViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Введённое имя пользователя
    @Published var firstname = ""
    /// Введённая фамилия пользователя
    @Published var lastname = ""
    /// Введённый email
    @Published var email = ""
    /// Введённое имя пользователя (логин)
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
    /// - Parameter session: Объект `SessionViewModel`, управляющий сессией.
    init(session: SessionViewModel) {
        self.session = session
    }
    
    // MARK: - Actions

    /// Регистрация нового пользователя с валидацией
    func register() async {
        showError = false

        guard !firstname.isEmpty,
              !lastname.isEmpty,
              !email.isEmpty,
              !username.isEmpty,
              !password.isEmpty else {
            errorMessage = Constants.Text.Register.allFieldsRequired
            showError = true
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage = Constants.Text.Register.invalidEmail
            showError = true
            return
        }
        
        guard password.count >= Constants.Validation.passwordMinLength else {
            errorMessage = Constants.Text.Register.passwordTooShort
            showError = true
            return
        }

        let success = await session.register(
            email: email,
            username: username,
            password: password,
            firstname: firstname,
            lastname: lastname
        )
        
        if !success {
            errorMessage = Constants.Text.Register.registrationErrorMessage
            showError = true
        }
    }
}
