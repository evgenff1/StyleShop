//
//  ProductRowView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import SwiftUI

/// Представление строки с краткой информацией о товаре
struct ProductRowView: View {
    
    /// Отображаемый товар
    let product: Product
    
    var body: some View {
        HStack(spacing: Constants.Layout.productRowSpacing) {
            // Миниатюра товара
            RemoteImageView(
                urlString: product.image,
                width: Constants.Layout.productImageSize,
                height: Constants.Layout.productImageSize
            )
            
            // Информация о товаре рейтинг, название, цена
            VStack(alignment: .leading, spacing: Constants.Layout.productInfoSpacing) {
                HStack(spacing: Constants.Layout.productRatingSpacing) {
                    Image(systemName: Constants.Images.System.starFill)
                        .foregroundColor(.yellow)
                    Text(String(format: Constants.Format.ratingOneDecimal, product.rating.rate))
                    
                    Image(systemName: Constants.Images.System.personFill)
                        .foregroundColor(.gray)
                    Text("\(product.rating.count)")
                        .foregroundColor(.gray)
                }
                .font(.subheadline)
                .padding(.bottom, Constants.Layout.productInfoTextBottomPadding)
                
                Text(product.title)
                    .font(.headline)
                    .padding(.bottom, Constants.Layout.productInfoTextBottomPadding)
                
                Spacer()
                
                Text("$\(product.price, specifier: Constants.Format.priceTwoDecimals)")
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Кнопки "в избранное" и "в корзину"
            ActionButtonsView(product: product)
                .buttonStyle(.plain)
        }
        .padding(.vertical, Constants.Layout.smallSpacing)
    }
}
