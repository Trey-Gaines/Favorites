//
//  CityCard.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//

import SwiftUI

struct CityCard: View {
    var city: CityModel
    @Bindable var favorites: FavoritesViewModel
    
    var body: some View {
            ZStack {
                Image(city.cityImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack {
                    Spacer()
                    HStack {
                        Text(city.cityName)
                            .padding(5)
                            .background(.thickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        Spacer()
                        Button {
                            favorites.favoriteCity(city.id)
                        } label: {
                            if favorites.favoriteCities[city.id] != nil  {
                                Image(systemName: "heart.fill").foregroundColor(.red)
                            } else { Image(systemName: "heart").foregroundColor(.blue) }
                        }
                    }
                    .padding()
                }
            }.padding(.all, 8)
    }
}


#Preview {
    CityCard(city: CityModel(id : 1, cityName: "Cape Town", cityImage: "capetown", isFavorite: false), favorites: FavoritesViewModel())
}
