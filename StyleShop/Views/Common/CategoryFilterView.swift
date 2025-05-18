//
//  CategoryFilterView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 20.03.2025.
//

import SwiftUI

/// Позволяет пользователю выбрать категорию для фильтрации продуктов
struct CategoryFilterView: View {
    
    /// ViewModel, содержащий список категорий и текущую выбранную категорию
    @EnvironmentObject private var categoryVM: CategoryViewModel
    
    var body: some View {
        // Горизонтальный скролл для категорий
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.Layout.categoryItemSpacing) {
                ForEach(categoryVM.categories, id: \.self) { category in
                    Button {
                        // При выборе категории обновляется состояние ViewModel
                        categoryVM.selectCategory(category)
                    } label: {
                        Text(category.capitalized)
                            .font(.subheadline).bold()
                            .padding(Constants.Layout.smallSpacing)
                            .frame(minWidth: Constants.Layout.categoryItemMinWidth)
                            .background(
                                Capsule()
                                    .fill(categoryVM.selectedCategory == category
                                          ? Color.blue.opacity(Constants.Opacity.categorySelectedBackground)
                                          : Color.gray.opacity(Constants.Opacity.categoryBackground)
                                         )
                            )
                    }
                    .foregroundColor(categoryVM.selectedCategory == category ? .blue : .primary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, Constants.Layout.categoryVerticalPadding)
        }
    }
}
