//
//  ProductListView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import SwiftUI

/// Представление списка товаров с возможностью фильтрации по категории и поиску
struct ProductListView: View {
    
    /// ViewModel, содержащий список товаров
    @EnvironmentObject private var productVM: ProductViewModel
    /// ViewModel, управляющий выбранной категорией
    @EnvironmentObject private var categoryVM: CategoryViewModel
    /// ViewModel, отвечающий за поиск
    @EnvironmentObject private var searchVM: SearchViewModel
    
    /// Отфильтрованные товары в соответствии с текущим поисковым запросом и категорией
    private var filteredProducts: [Product] {
        // Возвращается список товаров, отфильтрованных по категории и строке поиска
        return searchVM.filteredProducts(productVM.products, category: categoryVM.selectedCategory)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.Layout.rowVerticalPadding) {
                if productVM.isLoading {
                    // Показ индикатора загрузки
                    Spacer()
                    
                    ProgressView(Constants.Text.ProductList.loading)
                        .progressViewStyle(.circular)
                    
                    Spacer()
                } else {
                    // Поле поиска и фильтр по категориям
                    SearchBarView(text: $searchVM.searchQuery)
                        .padding(.bottom, Constants.Layout.productListSearchBarBottomPadding)
                    
                    CategoryFilterView()
                    
                    Divider()
                    
                    // Список отфильтрованных товаров
                    List(filteredProducts, id: \.id) { product in
                        ProductRowWithNavigation(product: product)
                    }
                    .listStyle(.plain)
                    .padding(.bottom, Constants.Layout.productListListBottomPadding)
                    .refreshable {
                        // Обновляет список товаров с задержкой для того, чтобы полностью сработала прокрутка
                        try? await Task.sleep(nanoseconds: Constants.Timing.refreshDelayNanoseconds)
                        await productVM.loadProducts()
                    }
                }
            }
            .navigationTitle(Constants.Text.ProductList.navigationTitle)
        }
    }
}
