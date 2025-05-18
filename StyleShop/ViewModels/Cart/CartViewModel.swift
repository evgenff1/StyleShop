//
//  CartViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// ViewModel для управления корзиной покупок
@MainActor
final class CartViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Словарь с товарами в корзине productId и количество
    @Published var cart: [Int: Int] = [:]
    /// Флаг, указывающий, что заказ был оформлен
    @Published var orderPlaced = false
    
    // MARK: - Computed Properties
    
    /// Проверка, пуста ли корзина
    var isCartEmpty: Bool {
        cart.isEmpty
    }
    
    // MARK: - Cart Management
    
    /// Добавляется товар в корзину
    /// - Parameter id: Идентификатор товара
    func addToCart(_ id: Int) {
        cart[id, default: 0] += 1
    }
    
    /// Обновляется количество товара в корзине
    /// - Parameters:
    ///   - id: Идентификатор товара
    ///   - delta: Изменение количества
    func updateCart(_ id: Int, by delta: Int) {
        let newQty = (cart[id] ?? 0) + delta
        if newQty > 0 {
            cart[id] = newQty
        } else {
            cart.removeValue(forKey: id)
        }
    }
    
    /// Удаляется товар из корзины
    /// - Parameter id: Идентификатор товара
    func removeFromCart(_ id: Int) {
        cart.removeValue(forKey: id)
    }
    
    /// Вычисляется общая стоимость всех товаров в корзине
    /// - Parameter products: Список всех доступных продуктов
    /// - Returns: Общая сумма заказа
    func total(using products: [Product]) -> Double {
        cart.reduce(0) { acc, item in
            guard let product = products.first(where: { $0.id == item.key }) else { return acc }
            return acc + product.price * Double(item.value)
        }
    }
    
    /// Возвращается список товаров в корзине с их количеством
    /// - Parameter products: Список всех продуктов
    /// - Returns: Массив кортежей (product, quantity) для каждого товара в корзине
    func cartItems(using products: [Product]) -> [(product: Product, quantity: Int)] {
        cart.compactMap { id, qty in
            guard let product = products.first(where: { $0.id == id }) else { return nil }
            return (product, qty)
        }
    }
    
    /// Завершение оформление заказа
    func placeOrder() {
        orderPlaced = true
    }
}
