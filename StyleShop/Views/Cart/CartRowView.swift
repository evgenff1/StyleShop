//
//  CartRowView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import SwiftUI

/// Представление строки товара в корзине, включающее управление количеством и удалением
struct CartRowView: View {
    
    /// Товар, отображаемый в строке корзины
    let product: Product
    
    var body: some View {
        HStack(spacing: Constants.Layout.productRowSpacing) {
            // Миниатюра изображения товара
            RemoteImageView(
                urlString: product.image,
                width: Constants.Layout.productImageSize,
                height: Constants.Layout.productImageSize
            )
            
            VStack(alignment: .leading, spacing: Constants.Layout.cartRowInnerSpacing) {
                // Название товара
                Text(product.title)
                    .font(.headline)
                    .padding(.bottom, Constants.Layout.cartRowTitleBottomPadding)
                
                // Цена товара
                Text("$\(product.price, specifier: Constants.Format.priceTwoDecimals)")
                    .foregroundColor(.blue)
                
                // Элементы управления количеством
                CartQuantityControls(product: product)
                    .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, Constants.Layout.smallSpacing)
    }
}
