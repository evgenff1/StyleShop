//
//  AuthTextField.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 22.03.2025.
//

import SwiftUI

/// Модифицированное текстовое поле для ввода данных с заголовком
/// Используется на экранах авторизации и регистрации
struct AuthTextField: View {
    
    /// Заголовок текстового поля
    let title: String
    /// Плейсхолдер внутри поля ввода
    let placeholder: String
    /// Привязанный текст, вводимый пользователем
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.Layout.fieldTitleSpacing) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .padding(.vertical, Constants.Layout.fieldInnerVerticalPadding)
                .padding(.horizontal, Constants.Layout.fieldInnerHorizontalPadding)
                .background(Color(.secondarySystemBackground))
                .disableAutocorrection(true)
                .cornerRadius(Constants.Layout.fieldCornerRadius)
        }
    }
}
