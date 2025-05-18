//
//  ProfileViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// ViewModel для экрана профиля пользователя
@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Показывать ли экран заказов
    @Published var showOrders = false
    /// Показывать ли экран с платёжной картой
    @Published var showCard = false
    /// Показывать ли настройки
    @Published var showSettings = false
    /// Показывать ли настройки пароля
    @Published var showPasswordSettings = false
    /// Показывать ли экран поддержки
    @Published var showSupport = false
}
