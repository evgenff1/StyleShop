//
//  ProductDetailView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 17.03.2025.
//

import SwiftUI

/// Представление детальной информации о товаре
struct ProductDetailView: View {
    
    /// ViewModel, управляющий корзиной покупок
    @EnvironmentObject private var cartVM: CartViewModel
    /// ViewModel, управляющий избранными товарами
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    /// ViewModel, управляющий текущей вкладкой
    @EnvironmentObject private var tabVM: TabViewModel
    
    /// Отображаемый товар
    let product: Product
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.Layout.detailInnerSpacing) {
                    // Изображение товара
                    RemoteImageView(
                        urlString: product.image,
                        width: nil,
                        height: Constants.Layout.detailImageHeight
                    )
                    .frame(maxWidth: .infinity)
                    .padding(Constants.Layout.mediumSpacing)
                    
                    // Название товара
                    Text(product.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    
                    // Описание товара
                    Text(product.description)
                        .font(.body)
                        .padding(.horizontal)
                    
                    // Рейтинг, количество отзывов и категория
                    HStack {
                        HStack(spacing: Constants.Layout.productRatingSpacing) {
                            Image(systemName: Constants.Images.System.starFill)
                                .foregroundColor(.yellow)
                            Text(String(format: Constants.Format.ratingOneDecimal, product.rating.rate))
                            
                            Image(systemName: Constants.Images.System.personFill)
                                .foregroundColor(.gray)
                            Text("\(product.rating.count)")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(product.category.capitalized)
                            .padding(Constants.Layout.smallSpacing)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(Constants.Opacity.categoryBackground))
                            )
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    
                    // Цена
                    Text("$\(product.price, specifier: Constants.Format.priceTwoDecimals)")
                        .foregroundColor(.blue)
                        .padding(.top, Constants.Layout.mediumSpacing)
                        .padding(.horizontal)
                }
            }
            
            // Кнопка "Добавить в корзину" или "Перейти в корзину"
            Button(action: {
                // Добавляет товар в корзину или переключает вкладку на корзину
                if cartVM.cart[product.id] != nil {
                    tabVM.selectedTab = .cart
                } else {
                    cartVM.addToCart(product.id)
                }
            }) {
                HStack {
                    Image(systemName: cartVM.cart[product.id] != nil
                          ? Constants.Images.System.cart
                          : Constants.Images.System.cartPlus)
                    Text(cartVM.cart[product.id] != nil
                         ? Constants.Text.ProductDetail.goToCart
                         : Constants.Text.ProductDetail.addToCart)
                    .bold()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.green)
                .cornerRadius(Constants.Layout.buttonCornerRadius)
            }
            .padding()
        }
        .navigationTitle(Constants.Text.ProductDetail.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // Кнопка избранного
                CircleIconButton(
                    systemImage: favoritesVM.isFavorite(product.id)
                    ? Constants.Images.System.heartFill
                    : Constants.Images.System.heart,
                    color: .red
                ) {
                    favoritesVM.toggleFavorite(product.id)
                }
            }
        }
    }
}
