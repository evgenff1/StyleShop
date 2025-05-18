//
//  RegisterView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

/// Экран регистрации нового пользователя
struct RegisterView: View {
    
    /// ViewModel, управляющий логикой регистрации
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            // Заголовки экрана регистрации
            VStack(spacing: Constants.Layout.smallSpacing) {
                Text(Constants.Text.Register.title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                
                Text(Constants.Text.Register.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(Constants.Opacity.secondaryText))
            }
            .padding(.bottom, Constants.Layout.largeSpacing)
            
            // Поля ввода пользовательских данных
            VStack(spacing: Constants.Layout.mediumSpacing) {
                AuthTextField(
                    title: Constants.Text.Register.firstNameFieldTitle,
                    placeholder: Constants.Text.Register.firstNamePlaceholder,
                    text: $viewModel.firstname
                )
                
                AuthTextField(
                    title: Constants.Text.Register.lastNameFieldTitle,
                    placeholder: Constants.Text.Register.lastNamePlaceholder,
                    text: $viewModel.lastname
                )
                
                AuthTextField(
                    title: Constants.Text.Register.emailFieldTitle,
                    placeholder: Constants.Text.Register.emailPlaceholder,
                    text: $viewModel.email
                )
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                
                AuthTextField(
                    title: Constants.Text.Register.usernameFieldTitle,
                    placeholder: Constants.Text.Register.usernamePlaceholder,
                    text: $viewModel.username
                )
                .textInputAutocapitalization(.never)
                
                PasswordField(
                    title: Constants.Text.Register.passwordFieldTitle,
                    placeholder: Constants.Text.Register.passwordPlaceholder,
                    text: $viewModel.password
                )
            }
            .padding(.horizontal)
            
            // Кнопка "Зарегистрироваться"
            Button {
                Task { await viewModel.register() }
            } label: {
                Text(Constants.Text.Register.signUpButton)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Constants.Layout.buttonVerticalPadding)
                    .background(Color.blue)
                    .cornerRadius(Constants.Layout.authButtonCornerRadius)
            }
            .padding(.horizontal)
            .padding(.top, Constants.Layout.mediumSpacing)
            
            // Переход к экрану авторизации
            HStack {
                Text(Constants.Text.Register.alreadyHaveAccount)
                    .font(.subheadline)
                
                NavigationLink(
                    Constants.Text.Register.signInLink,
                    destination: LoginView(viewModel: LoginViewModel(session: viewModel.session))
                )
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            .padding(.top, Constants.Layout.mediumSpacing)
            
            Spacer()
        }
        // Отображение ошибки регистрации
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text(Constants.Text.Register.registrationErrorTitle),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text(Constants.Text.Auth.okButton))
            )
        }
    }
}
