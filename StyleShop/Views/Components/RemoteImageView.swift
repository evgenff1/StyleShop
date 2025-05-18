//
//  RemoteImageView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import SwiftUI
import Kingfisher

/// Представление для отображения удалённого изображения по URL
/// Библиотека Kingfisher для загрузки и кэширования
struct RemoteImageView: View {
    
    /// Строка с URL изображения
    let urlString: String
    /// Ширина изображения
    let width: CGFloat?
    /// Высота изображения
    let height: CGFloat?
    
    var body: some View {
        if let url = URL(string: urlString) {
            KFImage(url)
                .placeholder {
                    // Отображается во время загрузки изображения
                    ProgressView()
                        .frame(width: width, height: height)
                }
                .retry(maxCount: 3, interval: .seconds(2)) // Повторные попытки при неудаче
                .onFailure { error in
                    print("Image load error:", error) // Лог ошибки
                }
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .clipped()
        } else {
            // Если URL некорректен отображается иконка по умолчанию
            Image(systemName: Constants.Images.System.placeholderImage)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .foregroundColor(.gray)
        }
    }
}
