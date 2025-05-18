//
//  TabViewModel.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// ViewModel для управления текущей выбранной вкладкой
@MainActor
final class TabViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Текущая выбранная вкладка приложения
    @Published var selectedTab: Constants.Tab = .catalog
}
