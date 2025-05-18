//
//  ProductRowWithNavigation.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 18.03.2025.
//

import SwiftUI

/// Представление строки товара с возможностью перехода на экран деталей
/// Отображает либо ProductRowView, либо CartRowView в зависимости от контекста
struct ProductRowWithNavigation: View {
    
    /// Товар, который отображается в строке
    let product: Product
    /// Флаг, определяющий контекст отображения корзина true или обычный список false
    var isCartView: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.Layout.rowVerticalPadding) {
            ZStack {
                // Невидимая навигационная ссылка для перехода на экран деталей товара
                NavigationLink(destination: ProductDetailView(product: product)) {
                    EmptyView()
                }
                .opacity(Constants.Opacity.hidden)
                .allowsHitTesting(false)
                
                // Отображение строки в зависимости от контекста корзина или список
                if !isCartView {
                    ProductRowView(product: product)
                } else {
                    CartRowView(product: product)
                }
            }
            .frame(height: Constants.Layout.productRowHeight)
            
            Divider()
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.init(
            top: Constants.Layout.rowVerticalPadding,
            leading: Constants.Layout.horizontalPadding,
            bottom: Constants.Layout.rowVerticalPadding,
            trailing: Constants.Layout.horizontalPadding
        ))
    }
}
