//
//  FavoritesAppApp.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//

import SwiftUI

@main
struct FavoritesAppApp: App {
    @State var myFavorites = FavoritesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(myFavorites.preferredStyle)
                .environment(myFavorites)
        }
    }
}
