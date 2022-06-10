//
//  Book.swift
//  Books
//
//  Created by Alexandra Zambitchi on 01.06.2022.
//

import Foundation

struct BooksJson: Codable {
    var books: [Books]?
}

struct Books: Codable {
    var year:Int?
    var title:String?
    var author:String?
    var no_pages:Int?
    var genre:String?
}
