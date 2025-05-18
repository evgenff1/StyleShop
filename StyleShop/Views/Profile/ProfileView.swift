//
//  ProfileView.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 19.03.2025.
//

import SwiftUI

/// Представление профиля пользователя
/// Показывает информацию о пользователе, меню навигации, а также кнопку выхода
/// Если пользователь не аутентифицирован отображает экран с предложением войти
struct ProfileView: View {

    /// ViewModel сессии, содержащий информацию об аутентификации и текущем пользователе
    @EnvironmentObject private var session: SessionViewModel
    /// ViewModel профиля, управляющий переходами к подпунктам меню
    @StateObject private var profileVM = ProfileViewModel()

    var body: some View {
        NavigationView {
            Group {
                // Если пользователь аутентифицирован и данные пользователя доступны
                if session.isAuthenticated, let user = session.user {
                    Form {
                        // Секция с отображением информации о пользователе
                        Section(header: Text(Constants.Text.Profile.SectionHeaders.userInfo)) {
                            HStack {
                                Text(Constants.Text.Profile.Fields.firstName)
                                Spacer()
                                Text(user.name?.firstname ?? "")
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Text(Constants.Text.Profile.Fields.lastName)
                                Spacer()
                                Text(user.name?.lastname ?? "")
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Text(Constants.Text.Profile.Fields.username)
                                Spacer()
                                Text(user.username ?? "")
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Text(Constants.Text.Profile.Fields.email)
                                Spacer()
                                Text(user.email ?? "")
                                    .foregroundColor(.secondary)
                            }
                        }

                        // Секция с меню навигации
                        Section {
                            ProfileMenuItemView(title: Constants.Text.Profile.MenuItems.orders) {
                                profileVM.showOrders.toggle()
                            }
                            .background(
                                // Навигация к экрану заказов
                                NavigationLink("", isActive: $profileVM.showOrders) {
                                    Text(Constants.Text.Profile.MenuItems.orders)
                                }.hidden()
                            )

                            ProfileMenuItemView(title: Constants.Text.Profile.MenuItems.myCards) {
                                profileVM.showCard.toggle()
                            }
                            .background(
                                // Навигация к экрану банковских карт
                                NavigationLink("", isActive: $profileVM.showCard) {
                                    Text(Constants.Text.Profile.MenuItems.myCards)
                                }.hidden()
                            )

                            ProfileMenuItemView(title: Constants.Text.Profile.MenuItems.settings) {
                                profileVM.showSettings.toggle()
                            }
                            .background(
                                // Навигация к настройкам
                                NavigationLink("", isActive: $profileVM.showSettings) {
                                    Text(Constants.Text.Profile.MenuItems.settings)
                                }.hidden()
                            )

                            ProfileMenuItemView(title: Constants.Text.Profile.MenuItems.changePassword) {
                                profileVM.showPasswordSettings.toggle()
                            }
                            .background(
                                // Навигация к смене пароля
                                NavigationLink("", isActive: $profileVM.showPasswordSettings) {
                                    Text(Constants.Text.Profile.MenuItems.changePassword)
                                }.hidden()
                            )

                            ProfileMenuItemView(title: Constants.Text.Profile.MenuItems.support) {
                                profileVM.showSupport.toggle()
                            }
                            .background(
                                // Навигация к службе поддержки
                                NavigationLink("", isActive: $profileVM.showSupport) {
                                    Text(Constants.Text.Profile.MenuItems.support)
                                }.hidden()
                            )
                        }

                        // Секция с кнопкой выхода из аккаунта
                        Section {
                            Button(role: .destructive) {
                                // Вызывает выход пользователя из аккаунта
                                session.logout()
                            } label: {
                                Text(Constants.Text.Profile.MenuItems.logOut)
                            }
                        }
                    }

                } else {
                    // Экран для неавторизованного пользователя
                    VStack(spacing: Constants.Layout.mediumSpacing) {
                        Text(Constants.Text.Profile.guestMessage)
                            .foregroundColor(.gray)

                        // Кнопка входа в аккаунт
                        Button(Constants.Text.Profile.loginButton) {
                            session.hasSeenAuth = false
                        }
                        .padding(.vertical, Constants.Layout.buttonVerticalPadding)
                        .padding(.horizontal, Constants.Layout.mediumSpacing)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(Constants.Layout.cartFooterButtonCornerRadius)
                    }
                    .padding()
                }
            }
            .navigationTitle(Constants.Text.Profile.navigationTitle)
        }
    }
}
