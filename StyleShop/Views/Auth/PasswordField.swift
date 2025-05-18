//
//  PasswordField.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 22.03.2025.
//

import SwiftUI

/// Поле ввода пароля с возможностью скрыть и показать введённый текст
struct PasswordField: View {
    
    /// Заголовок поля
    let title: String
    /// Плейсхолдер внутри поля
    let placeholder: String
    /// Привязанный пароль
    @Binding var text: String
    /// Флаг отображения и скрытия пароля
    @State private var showPassword = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Layout.fieldTitleSpacing) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                Group {
                    if showPassword {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                .padding(.horizontal, Constants.Layout.fieldInnerHorizontalPadding)
                .frame(height: Constants.Layout.passwordFieldHeight)
                
                // Кнопка показа и скрытия пароля
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword
                          ? Constants.Images.System.eye
                          : Constants.Images.System.eyeSlash)
                    .padding(Constants.Layout.iconButtonPadding)
                }
            }
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.Layout.fieldCornerRadius)
        }
    }
}
