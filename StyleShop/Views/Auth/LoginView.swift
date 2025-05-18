//
//  LoginView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

/// Экран авторизации пользователя
struct LoginView: View {

    /// ViewModel, управляющий логикой авторизации
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            // Заголовки экрана авторизации
            VStack(spacing: Constants.Layout.smallSpacing) {
                Text(Constants.Text.Auth.loginTitle)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                
                Text(Constants.Text.Auth.loginSubtitle)
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(Constants.Opacity.secondaryText))
            }
            .padding(.bottom, Constants.Layout.largeSpacing)
            
            // Поля ввода имени пользователя и пароля
            VStack(spacing: Constants.Layout.mediumSpacing) {
                AuthTextField(
                    title: Constants.Text.Auth.usernameFieldTitle,
                    placeholder: Constants.Text.Auth.usernamePlaceholder,
                    text: $viewModel.username
                )
                .textInputAutocapitalization(.never)
                
                PasswordField(
                    title: Constants.Text.Auth.passwordFieldTitle,
                    placeholder: Constants.Text.Auth.passwordPlaceholder,
                    text: $viewModel.password
                )
                
                Button(Constants.Text.Auth.forgotPassword) {
                    // Обработка восстановления пароля
                }
                .font(.caption)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal)
            
            // Кнопки "Войти" и "Продолжить как гость"
            VStack(spacing: Constants.Layout.smallSpacing) {
                Button {
                    Task { await viewModel.login() }
                } label: {
                    Text(Constants.Text.Auth.loginButton)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Constants.Layout.buttonVerticalPadding)
                        .background(Color.blue)
                        .cornerRadius(Constants.Layout.authButtonCornerRadius)
                }
                
                Button(Constants.Text.Auth.continueAsGuest) {
                    viewModel.continueAsGuest()
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.top, Constants.Layout.mediumSpacing)
            
            // Переход на экран регистрации
            HStack {
                Text(Constants.Text.Auth.dontHaveAccount)
                    .font(.subheadline)
                
                NavigationLink(
                    Constants.Text.Auth.registerLink,
                    destination: RegisterView(viewModel: RegisterViewModel(session: viewModel.session))
                )
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            .padding(.top, Constants.Layout.mediumSpacing)
            
            Spacer()
        }
        // Отображение ошибки, если авторизация не удалась
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text(Constants.Text.Auth.loginErrorTitle),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(Constants.Text.Auth.okButton))
            )
        }
    }
}
