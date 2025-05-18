//
//  SearchBarView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

/// Компонент поисковой строки для фильтрации или поиска товаров
struct SearchBarView: View {
    
    /// Привязанный текст поиска
    @Binding var text: String
    
    var body: some View {
        HStack {
            // Иконка лупы
            Image(systemName: Constants.Images.System.magnifyingGlass)
                .foregroundColor(.gray)
            
            // Поле ввода текста поиска
            TextField(Constants.Text.SearchBar.placeholder, text: $text)
                .disableAutocorrection(true)
        }
        .padding(Constants.Layout.searchBarInnerPadding)
        .background(Color(.systemGray6))
        .cornerRadius(Constants.Layout.fieldCornerRadius)
        .padding(.horizontal)
    }
}
