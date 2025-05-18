//
//  ProfileMenuItemView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 23.03.2025.
//

import SwiftUI

/// Представление отдельного пункта меню профиля с заголовком и иконкой перехода
struct ProfileMenuItemView: View {
    
    /// Название пункта меню
    let title: String
    /// Действие, выполняемое при нажатии на пункт
    let action: () -> Void
    
    var body: some View {
        // Кнопка пункта меню
        Button(action: action) {
            HStack {
                // Заголовок пункта
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                // Иконка стрелки вправо
                Image(systemName: Constants.Images.System.chevronRight)
                    .foregroundColor(.secondary)
            }
        }
    }
}
