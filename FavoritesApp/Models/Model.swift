//
//  Model.swift
//  Favorites
//
//  Created by Trey Gaines on 7/14/25.
//

import Foundation

protocol Favoritable : Identifiable {
    var id : Int { get }
    var isFavorite : Bool { get set }
    var searchableText : String { get }
}

struct CityModel : Favoritable, Equatable {
    let id: Int
    let cityName: String
    let cityImage: String
    var isFavorite: Bool = false
    
    var searchableText: String {
        return cityName
    }
}

struct HobbyModel : Favoritable, Equatable {
    let id: Int
    let hobbyName: String
    let hobbyIcon: String
    var isFavorite: Bool = false
    
    var searchableText: String {
        return hobbyName
    }
}

struct BookModel : Favoritable, Equatable {
    let id: Int
    let bookTitle: String
    let bookAuthor: String
    var isFavorite: Bool = false
    
    var searchableText: String {
        return bookTitle + " " + bookAuthor
    }
}


enum UserDefaultsKey: String {
    case darkModeEnabled
    case cityFavorites
    case hobbyFavorites
    case bookFavorites
}


extension UserDefaults {
    
    //Cities
    func getFavoriteCities() -> Set<Int> {
        let array = self.array(forKey: UserDefaultsKey.cityFavorites.rawValue) as? [Int] ?? []
        return Set(array)
    }

    func saveFavoriteCities(_ cities: Set<Int>) {
        self.set(Array(cities), forKey: UserDefaultsKey.cityFavorites.rawValue)
    }

    func addFavoriteCity(_ cityId: Int) {
        var favorites = getFavoriteCities()
        favorites.insert(cityId)
        saveFavoriteCities(favorites)
    }

    func removeFavoriteCity(_ cityId: Int) {
        var favorites = getFavoriteCities()
        favorites.remove(cityId)
        saveFavoriteCities(favorites)
    }
    
    
    
    
    //Hobbies
    func getFavoriteHobbies() -> Set<Int> {
        let array = self.array(forKey: UserDefaultsKey.hobbyFavorites.rawValue) as? [Int] ?? []
        return Set(array)
    }
    
    func saveFavoriteHobbies(_ hobbies: Set<Int>) {
        self.set(Array(hobbies), forKey: UserDefaultsKey.hobbyFavorites.rawValue)
    }

    func addFavoriteHobby(_ hobbyId: Int) {
        var favorites = getFavoriteHobbies()
        favorites.insert(hobbyId)
        saveFavoriteHobbies(favorites)
    }

    func removeFavoriteHobby(_ hobbyId: Int) {
        var favorites = getFavoriteHobbies()
        favorites.remove(hobbyId)
        saveFavoriteHobbies(favorites)
    }
    
    
    //Books
    func getFavoriteBooks() -> Set<Int> {
        let array = self.array(forKey: UserDefaultsKey.bookFavorites.rawValue) as? [Int] ?? []
        return Set(array)
    }
    
    func saveFavoriteBooks(_ books: Set<Int>) {
        self.set(Array(books), forKey: UserDefaultsKey.bookFavorites.rawValue)
    }

    func addFavoriteBook(_ bookId: Int) {
        var favorites = getFavoriteBooks()
        favorites.insert(bookId)
        saveFavoriteBooks(favorites)
    }

    func removeFavoriteBook(_ bookId: Int) {
        var favorites = getFavoriteBooks()
        favorites.remove(bookId)
        saveFavoriteBooks(favorites)
    }
    
    
    
    
    func resetAll() {
        self.set([], forKey: UserDefaultsKey.hobbyFavorites.rawValue)
        self.set([], forKey: UserDefaultsKey.bookFavorites.rawValue)
        self.set([], forKey: UserDefaultsKey.cityFavorites.rawValue)
    }
}
