//
//  Constants.swift
//  StyleShop
//
//  Created by Evgeniy Fakhretdinov on 24.03.2025.
//

import SwiftUI

enum Constants {
    
    // MARK: - Tab Identifiers
    enum Tab: Hashable {
        case catalog, cart, favorites, profile
    }
    
    // MARK: - UserDefaults Keys
    enum Keys {
        static let hasSeenAuth = "hasSeenAuth"
        static let isAuthenticated = "isAuthenticated"
        static let authToken = "authToken"
        static let currentUser = "currentUser"
    }
    
    // MARK: - Network Constants
    enum Network {
        enum HTTPMethod {
            static let post = "POST"
        }
        
        enum HeaderField {
            static let contentType = "Content-Type"
        }
        
        enum HeaderValue {
            static let applicationJSON = "application/json"
        }
        
        enum JSONKeys {
            static let username = "username"
            static let password = "password"
            static let email = "email"
            static let name = "name"
            static let firstname = "firstname"
            static let lastname = "lastname"
        }
    }
    
    // MARK: - API Configuration
    enum API {
        static let scheme = "https"
        static let host = "fakestoreapi.com"
        
        enum Paths {
            static let products = "/products"
            static let productCategories = "/products/categories"
            static let authLogin = "/auth/login"
            static let users = "/users"
            static let userById = "/users/"
        }
    }
    
    // MARK: - Network Error Messages
    enum NetworkError {
        static let badURL = "Invalid URL. Please try again later."
        static let invalidResponse = "The server returned an invalid response."
        static let decodingFailed = "Failed to decode data from the server."
        static let serverError = "Server error: "
    }
    
    // MARK: - Format Strings
    enum Format {
        static let ratingOneDecimal = "%.1f"
        static let priceTwoDecimals = "%.2f"
    }
    
    // MARK: - Opacity Levels
    enum Opacity {
        static let secondaryText: Double = 0.4
        static let categorySelectedBackground: Double = 0.2
        static let categoryBackground: Double = 0.1
        static let hidden: Double = 0.0
        static let cartOrderPlacedNotEmpty = 1.0
        static let cartOrderPlacedEmpty = 0.5
    }
    
    // MARK: - UI Text Constants
    enum Text {
        
        // MARK: Authentication
        enum Auth {
            static let loginTitle = "Login"
            static let loginSubtitle = "Enter your username and password"
            static let usernameFieldTitle = "Username"
            static let usernamePlaceholder = "Enter your username"
            static let passwordFieldTitle = "Password"
            static let passwordPlaceholder = "Your password"
            static let forgotPassword = "Forgot Password?"
            static let loginButton = "Log In"
            static let continueAsGuest = "Continue as Guest"
            static let loginErrorTitle = "Login Error"
            static let loginErrorMessage = "Login failed. Please check your credentials."
            static let okButton = "OK"
            static let dontHaveAccount = "Don't have an account?"
            static let registerLink = "Register"
            static let unknownServerError = "Unknown server error"
        }
        
        // MARK: Registration
        enum Register {
            static let title = "Sign Up"
            static let subtitle = "Enter your details to register"
            static let firstNameFieldTitle = "First Name"
            static let firstNamePlaceholder = "Enter your first name"
            static let lastNameFieldTitle = "Last Name"
            static let lastNamePlaceholder = "Enter your last name"
            static let emailFieldTitle = "Email"
            static let emailPlaceholder = "Enter your email"
            static let usernameFieldTitle = "Username"
            static let usernamePlaceholder = "Enter your username"
            static let passwordFieldTitle = "Password"
            static let passwordPlaceholder = "Your password"
            static let signUpButton = "Sign Up"
            static let registrationErrorTitle = "Registration Error"
            static let registrationErrorMessage = "Registration failed. Please check your details."
            static let alreadyHaveAccount = "Already have an account?"
            static let signInLink = "Sign In"
            static let allFieldsRequired = "All fields are required."
            static let invalidEmail = "Please enter a valid email address."
            static let passwordTooShort = "Password must be at least 6 characters."
        }
        
        // MARK: Main Tab Titles
        enum MainTabs {
            static let catalog = "Catalog"
            static let cart = "Cart"
            static let favorites = "Favorites"
            static let profile = "Profile"
        }
        
        // MARK: Product List
        enum ProductList {
            static let navigationTitle = "Catalog"
            static let loading = "Loading…"
        }
        
        // MARK: Search Bar
        enum SearchBar {
            static let placeholder = "Search products..."
        }
        
        // MARK: Product Detail
        enum ProductDetail {
            static let navigationTitle = "Product Details"
            static let addToCart = "Add to Cart"
            static let goToCart = "Go to Cart"
        }
        
        // MARK: Cart
        enum Cart {
            static let total = "Total:"
            static let placeOrderButton = "Place Order"
            static let orderCreated = "Your order has been successfully created!"
        }
        
        // MARK: Favorites
        enum Favorites {
            static let removeAction = "Remove"
        }
        
        // MARK: Profile
        enum Profile {
            static let navigationTitle = "Profile"
            static let guestMessage = "You are browsing as a guest."
            static let loginButton = "Log In"
            
            enum SectionHeaders {
                static let userInfo = "User Information"
            }
            enum Fields {
                static let firstName = "First Name"
                static let lastName = "Last Name"
                static let username = "Username"
                static let email = "Email"
            }
            enum MenuItems {
                static let orders = "Orders"
                static let myCards = "My Cards"
                static let settings = "Settings"
                static let changePassword = "Change Password"
                static let support = "Support"
                static let logOut = "Log Out"
            }
        }
        
        // MARK: Categories
        enum Category {
            static let all = "All"
        }
    }
    
    // MARK: - Validation Constants
    enum Validation {
        static let passwordMinLength = 6
    }
    
    // MARK: - Timing Constants
    enum Timing {
        static let refreshDelayNanoseconds: UInt64 = 700_000_000
    }
    
    // MARK: - Image Asset Names
    enum Images {
        enum System {
            static let catalog = "square.grid.2x2"
            static let cart = "cart"
            static let cartPlus = "cart.badge.plus"
            static let checkmark = "checkmark"
            static let heart = "heart"
            static let heartFill = "heart.fill"
            static let favorites = "heart"
            static let profile = "person.crop.circle"
            static let magnifyingGlass = "magnifyingglass"
            static let starFill = "star.fill"
            static let personFill = "person.fill"
            static let minusCircle = "minus.circle"
            static let plusCircle = "plus.circle"
            static let trash = "trash"
            static let eye = "eye"
            static let eyeSlash = "eye.slash"
            static let chevronRight = "chevron.right"
            static let placeholderImage = "tshirt"
        }
    }
    
    // MARK: - Layout Constants
    enum Layout {
        // Spacing
        static let horizontalPadding: CGFloat = 16
        static let smallSpacing: CGFloat = 8
        static let mediumSpacing: CGFloat = 16
        static let largeSpacing: CGFloat = 30
        
        // Buttons
        static let buttonCornerRadius: CGFloat = 12
        static let authButtonCornerRadius: CGFloat = 25
        static let buttonVerticalPadding: CGFloat = 12
        
        // SearchBar
        static let searchBarInnerPadding: CGFloat = 8
        
        // ProductRow
        static let productRowHeight: CGFloat = 140
        static let productImageSize: CGFloat = 100
        static let productRowSpacing: CGFloat = 16
        
        // ProductDetail
        static let detailImageHeight: CGFloat = 250
        static let detailInnerSpacing: CGFloat = 16
        
        // AuthTextField / PasswordField
        static let fieldTitleSpacing: CGFloat = 4
        static let fieldCornerRadius: CGFloat = 12
        static let fieldInnerVerticalPadding: CGFloat = 12
        static let fieldInnerHorizontalPadding: CGFloat = 12
        static let passwordFieldHeight: CGFloat = 50
        
        // CircleIconButton
        static let iconButtonSize: CGFloat = 20
        static let iconButtonPadding: CGFloat = 8
        
        // CartView footer
        static let cartFooterSpacing: CGFloat = 16
        static let cartFooterButtonCornerRadius: CGFloat = 8
        
        // ProductListView
        static let productListSearchBarBottomPadding: CGFloat = 8
        static let productListListBottomPadding: CGFloat = 16
        
        // CategoryFilterView
        static let categoryItemSpacing: CGFloat = 12
        static let categoryVerticalPadding: CGFloat = 4
        static let categoryItemMinWidth: CGFloat = 60
        
        // CartRowView
        static let cartRowInnerSpacing: CGFloat = 4
        static let cartRowTitleBottomPadding: CGFloat = 10
        
        // ProductRowView
        static let productInfoSpacing: CGFloat = 4
        static let productInfoTextBottomPadding: CGFloat = 10
        static let productRatingSpacing: CGFloat = 6
        
        // CartQuantityControls
        static let quantityLabelWidth: CGFloat = 24
        
        // Vertical padding
        static let rowVerticalPadding: CGFloat = 0
    }
}
