//
//  BookView.swift
//  FavoritesApp
//
//  Created by Trey Gaines on 7/14/25.
//
import SwiftUI

struct BookView: View {
    var book: BookModel
    @Bindable var favorites: FavoritesViewModel
    
    var body: some View {
        VStack {
            Text("\(book.bookTitle)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.all, 8)
            HStack {
                Text("\(book.bookAuthor)")
                    .italic()
                Spacer()
                Button {
                    favorites.favoriteBook(book.id)
                } label: {
                    if book.isFavorite {
                        Image(systemName: "heart.fill")
                    } else { Image(systemName: "heart") }
                }
            }
        }
    }
}
