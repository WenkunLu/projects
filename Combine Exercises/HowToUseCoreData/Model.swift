//
//  Model.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/2/19.
//

import Foundation




struct Book: Hashable {
    let id = UUID()
    var bookTitle: String
    var author: String
    var publicDate: Date
    
    var category: Categorie
    
    enum Categorie: String {
        case normal = "normal"
        case science = "science"
        case history = "history"
        case math = "math"
        case novel = "novel"
    }
    
    init(bookTitle: String, author: String, publicDate: Date, category: Categorie) {
        self.bookTitle = bookTitle
        self.author = author
        self.publicDate = publicDate
        self.category = category
    }
    
}

struct Shelf: Hashable {
    
    var shelfName: Book.Categorie
    var bookList: [Book]
    
    init(shelfName: Book.Categorie, bookList: [Book]) {
        self.shelfName = shelfName
        self.bookList = bookList
    }
}


