//
//  HobbyView.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//

import SwiftUI

struct HobbyView: View {
    var hobby: HobbyModel
    @Bindable var favorites: FavoritesViewModel
    
    var body: some View {
        HStack {
            Text(hobby.hobbyIcon)
            Text(hobby.hobbyName)
            
            Spacer()
            Button {
                favorites.favoriteHobby(hobby.id)
            } label: {
                if hobby.isFavorite {
                    Image(systemName: "heart.fill")
                } else { Image(systemName: "heart") }
            }
        }
    }
}
