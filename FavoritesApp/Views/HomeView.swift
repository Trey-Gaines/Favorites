//
//  HomeView.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//

import SwiftUI

struct Home: View {
    @Bindable var favorites: FavoritesViewModel

    var categories = ["Cities", "Hobbies", "Books"]
    var body: some View {
        NavigationStack {
            Picker("Category Type", selection: $favorites.currentCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }

            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Group {
                switch favorites.currentCategory {
                case "Cities":
                    List {
                        ForEach(favorites.filteredCities.indices, id: \.self) { element in
                            CityCard(city: favorites.filteredCities[element], favorites: favorites)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                        }
                    }.listStyle(.plain)
                case "Hobbies":
                    List {
                        ForEach(favorites.filteredHobbies.indices, id: \.self) { element in
                            HobbyView(hobby: favorites.filteredHobbies[element], favorites: favorites)
                        }
                    }.listStyle(.plain)
                case "Books":
                    List {
                        ForEach(favorites.filteredBooks.indices, id: \.self) { element in
                            BookView(book: favorites.filteredBooks[element], favorites: favorites)
                        }
                    }.listStyle(.plain)
                default:
                    Text("Default")
                }
            }
            Spacer()
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $favorites.searchQuery, prompt: "Search \(favorites.currentCategory)")
    }
}

#Preview {
    Home(favorites: FavoritesViewModel())
}
