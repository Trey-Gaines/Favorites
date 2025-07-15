//
//  Settings.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//
import SwiftUI

struct Settings: View {
    @Bindable var favorites: FavoritesViewModel
    

    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Appearance")) {
                    if favorites.isDarkModeEnabled {
                        Toggle("Dark Mode", systemImage: "moon.fill", isOn: $favorites.isDarkModeEnabled)
                    } else {
                        Toggle("Light Mode", systemImage: "sun.min.fill", isOn: $favorites.isDarkModeEnabled)
                    }
                }
                
                Section(header: Text("Data")) {
                    Button(role: .destructive) {
                        favorites.resetFavorites()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear All Favorites")
                        }
                    }.disabled(favorites.allEmpty)
                }
            }

            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Settings(favorites: FavoritesViewModel())
}
