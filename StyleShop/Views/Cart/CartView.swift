//
//  CartView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// Экран корзины с перечнем выбранных товаров, общей суммой и кнопкой оформления заказа
struct CartView: View {
    
    /// ViewModel корзины с текущими товарами и логикой оформления заказа
    @EnvironmentObject private var cartVM: CartViewModel
    /// ViewModel товаров используется для получения деталей о каждом товаре
    @EnvironmentObject private var productVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.Layout.rowVerticalPadding) {
                // Список товаров в корзине
                List(cartVM.cartItems(using: productVM.products), id: \.product.id) { item in
                    ProductRowWithNavigation(product: item.product, isCartView: true)
                }
                .listStyle(.plain)
                
                // Нижняя часть экрана общая сумма и кнопка оформления заказа
                VStack(spacing: Constants.Layout.cartFooterSpacing) {
                    HStack {
                        Text(Constants.Text.Cart.total)
                            .font(.headline)
                        
                        Spacer()
                        
                        // Общая сумма заказа, вычисленная на основе корзины
                        Text("$\(cartVM.total(using: productVM.products), specifier: Constants.Format.priceTwoDecimals)")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                    // Кнопка оформления заказа
                    Button(action: {
                        // Оформляет заказ, вызывая соответствующий метод ViewModel
                        cartVM.placeOrder()
                    }) {
                        Text(Constants.Text.Cart.placeOrderButton)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.Layout.cartFooterButtonCornerRadius)
                            .opacity(cartVM.isCartEmpty ? Constants.Opacity.cartOrderPlacedEmpty : Constants.Opacity.cartOrderPlacedNotEmpty)
                    }
                    .disabled(cartVM.isCartEmpty)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
            }
            .navigationTitle(Constants.Text.MainTabs.cart)
            .alert(
                Constants.Text.Cart.placeOrderButton,
                isPresented: $cartVM.orderPlaced
            ) {
                Button(Constants.Text.Auth.okButton) {}
            } message: {
                // Показывает сообщение после успешного оформления заказа
                Text(Constants.Text.Cart.orderCreated)
            }
        }
    }
}
