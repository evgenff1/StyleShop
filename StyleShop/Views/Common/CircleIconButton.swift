//
//  CircleIconButton.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 18.03.2025.
//

import SwiftUI

/// Кнопка с иконкой в форме круга
struct CircleIconButton: View {
    
    /// Название системного изображения отображаемого в кнопке
    let systemImage: String
    /// Цвет изображения
    let color: Color
    /// Замыкание, вызываемое при нажатии на кнопку
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Layout.iconButtonSize, height: Constants.Layout.iconButtonSize)
                .foregroundColor(color)
                .padding(Constants.Layout.iconButtonPadding)
                .background(Color(.systemGray6))
                .clipShape(Circle())
        }
    }
}
