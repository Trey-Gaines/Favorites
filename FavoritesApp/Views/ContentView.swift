//
//  ContentView.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(FavoritesViewModel.self) var favorites
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                Home(favorites: favorites)
            }
            
            Tab("Favorites", systemImage: "star") {
                Favorites(favorites: favorites)
            }
        
            Tab("Settings", systemImage: "gear") {
                Settings(favorites: favorites)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(FavoritesViewModel())
}


