//
//  CartQuantityControls.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// Компонент управления количеством товара в корзине увеличение, уменьшение и удаление
struct CartQuantityControls: View {
    
    /// ViewModel корзины, управляющий изменением количества
    @EnvironmentObject private var cartVM: CartViewModel
    /// Товар, количество которого изменяется
    let product: Product
    
    var body: some View {
        HStack {
            HStack {
                // Уменьшить количество товара
                CircleIconButton(systemImage: Constants.Images.System.minusCircle,
                                 color: .green
                ) {
                    // Уменьшает количество на 1
                    cartVM.updateCart(product.id, by: -1)
                }
                
                // Текущее количество
                Text("\(cartVM.cart[product.id] ?? 0)")
                    .frame(width: Constants.Layout.quantityLabelWidth)
                
                // Увеличить количество товара
                CircleIconButton(systemImage: Constants.Images.System.plusCircle,
                                 color: .green
                ) {
                    // Увеличивает количество на 1
                    cartVM.updateCart(product.id, by: 1)
                }
            }
            
            Spacer()
            
            // Кнопка удаления товара из корзины
            CircleIconButton(systemImage: Constants.Images.System.trash,
                             color: .red
            ) {
                // Полностью удаляет товар из корзины
                cartVM.removeFromCart(product.id)
            }
        }
    }
}
