//
//  Favorites.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//
import SwiftUI

struct Favorites: View {
    @Bindable var favorites: FavoritesViewModel
    
    var cityList: [CityModel] {
        Array(favorites.favoriteCities.values)
    }

    var hobbyList: [HobbyModel] {
        Array(favorites.favoriteHobbies.values)
    }

    var bookList: [BookModel] {
        Array(favorites.favoriteBooks.values)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if favorites.allEmpty {
                    ContentUnavailableView("No Favorites Yet!", systemImage: "star.slash.fill")
                } else {
                    List {
                        Section(header: Text("Cities").font(.headline)) {
                            ForEach(cityList, id: \.self.cityName) { city in
                                CityCard(city: city, favorites: favorites)
                                    
                            }
                        }
                        
                        Section(header: Text("Hobbies").font(.headline)) {
                            ForEach(hobbyList, id: \.self.hobbyName) { hobby in
                                HobbyView(hobby: hobby, favorites: favorites)
                            }
                        }
                        
                        Section(header: Text("Books").font(.headline)) {
                            ForEach(bookList, id: \.self.bookTitle) { book in
                                BookView(book: book, favorites: favorites)
                            }
                        }
                        
                        
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    Favorites(favorites: FavoritesViewModel())
}
