//
// FavoritesViewModel.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import Observation
import SwiftUI


@Observable
class FavoritesViewModel {
    var cities: [CityModel] 
    var hobbies: [HobbyModel]
    var books: [BookModel]
    let userDefaults = UserDefaults.standard
    
    
    //For HomeView
    var searchQuery: String
    var currentCategory = "Cities"
    
    
    
    var filteredCities: [CityModel] {
        guard !searchQuery.isEmpty else { return cities }
        guard currentCategory == "Cities" else { return cities }
        
        return cities.filter {
            $0.searchableText.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    var filteredHobbies: [HobbyModel] {
        guard !searchQuery.isEmpty else { return hobbies }
        guard currentCategory == "Hobbies" else { return hobbies }
        
        return hobbies.filter {
            $0.searchableText.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    var filteredBooks: [BookModel] {
        guard !searchQuery.isEmpty else { return books }
        guard currentCategory == "Books" else { return books }
        
        return books.filter {
            $0.searchableText.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    
    //For FavoritesView
    var favoriteCities: [Int: CityModel]
    var favoriteHobbies: [Int: HobbyModel]
    var favoriteBooks: [Int: BookModel]
    
    var allEmpty: Bool { favoriteCities.isEmpty && favoriteHobbies.isEmpty && favoriteBooks.isEmpty }
        
    func favoriteCity(_ id: Int) {
        let index = cities.firstIndex(of: cities.first(where: { $0.id == id })!)!
        print("Favorite city \(cities[index].cityName)")
        cities[index].isFavorite.toggle()
        let myBool = cities[index].isFavorite
        
        if myBool {
            favoriteCities[id] = cities[index]
            UserDefaults.standard.addFavoriteCity(cities[index].id)
        } else {
            favoriteCities.removeValue(forKey: id)
            UserDefaults.standard.removeFavoriteCity(cities[index].id)
        }
    }
    
    func favoriteHobby(_ id: Int) {
        let index = hobbies.firstIndex(of: hobbies.first(where: { $0.id == id })!)!
        print("Favorite hobby \(hobbies[index].hobbyName)")
        hobbies[index].isFavorite.toggle()
        let myBool = hobbies[index].isFavorite
        
        if myBool {
            favoriteHobbies[id] = hobbies[index]
            UserDefaults.standard.addFavoriteHobby(hobbies[index].id)
        } else {
            favoriteHobbies.removeValue(forKey: id)
            UserDefaults.standard.removeFavoriteHobby(hobbies[index].id)
        }
    }
    
    func favoriteBook(_ id: Int) {
        let index = books.firstIndex(of: books.first(where: { $0.id == id })!)!
        print("Favorite book \(books[index].bookTitle)")
        books[index].isFavorite.toggle()
        let myBool = books[index].isFavorite
        
        if myBool {
            favoriteBooks[id] = books[index]
            UserDefaults.standard.addFavoriteBook(books[index].id)
        } else {
            favoriteBooks.removeValue(forKey: id)
            UserDefaults.standard.removeFavoriteBook(books[index].id)
        }
    }
    
    
    
    //For Settings
    var isDarkModeEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isDarkModeEnabled, forKey: UserDefaultsKey.darkModeEnabled.rawValue)
        }
    }
    
    var preferredStyle: ColorScheme {
        if isDarkModeEnabled {
            .dark
        } else { .light }
    }
    
    func resetFavorites() {
        favoriteBooks.removeAll()
        favoriteCities.removeAll()
        favoriteHobbies.removeAll()
        userDefaults.resetAll()
    }
    
    
    
    //Other
    init(cities: [CityModel] = [], hobbies: [HobbyModel] = [], books: [BookModel] = []) {
        self.cities = sampleCities
        self.hobbies = sampleHobbies
        self.books = sampleBooks
        self.searchQuery = ""
        //Set by UserDefaults
        self.isDarkModeEnabled = UserDefaults.standard.object(forKey: UserDefaultsKey.darkModeEnabled.rawValue) as? Bool ?? true
        self.favoriteCities = FavoritesViewModel.addCities()
        self.favoriteHobbies = FavoritesViewModel.addHobbies()
        self.favoriteBooks = FavoritesViewModel.addBooks()
    }
    
    static func addCities() -> [Int: CityModel] {
        var myCities = [Int: CityModel]()
        let favorites =  UserDefaults.standard.getFavoriteCities()
        for favorite in favorites {
            let item = sampleCities.first(where: { $0.id == favorite })!
            myCities[favorite] = item
        }
        return myCities
    }
    
    static func addHobbies() -> [Int: HobbyModel] {
        var myHobbies = [Int: HobbyModel]()
        let favorites =  UserDefaults.standard.getFavoriteHobbies()
        for favorite in favorites {
            let item = sampleHobbies.first(where: { $0.id == favorite })!
            myHobbies[favorite] = item
        }
        return myHobbies
    }
    
    static func addBooks() -> [Int: BookModel] {
        var myBooks = [Int: BookModel]()
        let favorites =  UserDefaults.standard.getFavoriteBooks()
        for favorite in favorites {
            let item = sampleBooks.first(where: { $0.id == favorite })!
            myBooks[favorite] = item
        }
        return myBooks
    }
}


let sampleCities: [CityModel] = [
    CityModel(id : 1, cityName: "Cape Town", cityImage: "capetown", isFavorite: false),
    CityModel(id : 2, cityName: "Copenhagen", cityImage: "copenhagen", isFavorite: false),
    CityModel(id : 3, cityName: "Lisbon", cityImage: "lisbon", isFavorite: false),
    CityModel(id : 4, cityName: "Reykjavik", cityImage: "reykjavik", isFavorite: false),
    CityModel(id : 5, cityName: "Warsaw", cityImage: "warsaw", isFavorite: false),
    CityModel(id : 6, cityName: "London", cityImage: "london", isFavorite: false),
    CityModel(id : 7, cityName: "Monaco", cityImage: "monaco", isFavorite: false),
    CityModel(id : 8, cityName: "Amsterdam", cityImage: "amsterdam", isFavorite: false),
    CityModel(id : 9, cityName: "Los Angeles", cityImage: "losangeles", isFavorite: false)
]


let sampleHobbies: [HobbyModel] = [
    HobbyModel(id : 1, hobbyName: "Painting", hobbyIcon: "🎨", isFavorite: false),
    HobbyModel(id : 2, hobbyName: "Photography", hobbyIcon: "📷", isFavorite: false),
    HobbyModel(id : 3, hobbyName: "Guitar", hobbyIcon: "🎸", isFavorite: false),
    HobbyModel(id : 4, hobbyName: "Yoga", hobbyIcon: "🧘‍♀️", isFavorite: false),
    HobbyModel(id : 5, hobbyName: "Gardening", hobbyIcon: "🪴", isFavorite: false),
    HobbyModel(id : 6, hobbyName: "Cooking", hobbyIcon: "🍳", isFavorite: false),
    HobbyModel(id : 7, hobbyName: "Hiking", hobbyIcon: "🥾", isFavorite: false),
    HobbyModel(id : 8, hobbyName: "Writing", hobbyIcon: "✍️", isFavorite: false),
    HobbyModel(id : 9, hobbyName: "Dancing", hobbyIcon: "💃", isFavorite: false),
    HobbyModel(id : 10, hobbyName: "Knitting", hobbyIcon: "🧶", isFavorite: false),
    HobbyModel(id : 11, hobbyName: "Gaming", hobbyIcon: "🎮", isFavorite: false),
    HobbyModel(id : 12, hobbyName: "Calligraphy", hobbyIcon: "✒️", isFavorite: false),
]

let sampleBooks: [BookModel] = [
    BookModel(id : 1, bookTitle: "To Kill a Mockingbird", bookAuthor: "Harper Lee", isFavorite: false),
    BookModel(id : 2, bookTitle: "1984", bookAuthor: "George Orwell", isFavorite: false),
    BookModel(id : 3, bookTitle: "Pride and Prejudice", bookAuthor: "Jane Austen", isFavorite: false),
    BookModel(id : 4, bookTitle: "The Great Gatsby", bookAuthor: "F. Scott Fitzgerald", isFavorite: false),
    BookModel(id : 5, bookTitle: "The Catcher in the Rye", bookAuthor: "J.D. Salinger", isFavorite: false),
    BookModel(id : 6, bookTitle: "The Hobbit", bookAuthor: "J.R.R. Tolkien", isFavorite: false),
    BookModel(id : 7, bookTitle: "Fahrenheit 451", bookAuthor: "Ray Bradbury", isFavorite: false),
    BookModel(id : 8, bookTitle: "Jane Eyre", bookAuthor: "Charlotte Brontë", isFavorite: false),
    BookModel(id : 9, bookTitle: "The Alchemist", bookAuthor: "Paulo Coelho", isFavorite: false),
    BookModel(id : 10, bookTitle: "The Book Thief", bookAuthor: "Markus Zusak", isFavorite: false),
    BookModel(id : 11, bookTitle: "Moby-Dick", bookAuthor: "Herman Melville", isFavorite: false),
    BookModel(id : 12, bookTitle: "Crime and Punishment", bookAuthor: "Fyodor Dostoevsky", isFavorite: false)
]


