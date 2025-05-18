//
//  AuthWrapperView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 21.03.2025.
//

import SwiftUI

/// Показывается либо экран входа при первом запуске, либо основное содержимое приложения
struct AuthWrapperView: View {
    
    /// Модель пользовательской сессии, получаемая из окружения
    @EnvironmentObject private var session: SessionViewModel
    
    var body: some View {
        NavigationView {
            if !session.hasSeenAuth {
                LoginView(viewModel: LoginViewModel(session: session))
            } else {
                MainTabView()
            }
        }
    }
}
