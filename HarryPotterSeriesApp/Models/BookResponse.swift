//
//  BookResponse.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import Foundation

// MARK: - BookResponse
struct BookResponse: Decodable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Decodable {
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Decodable {
    let title, author: String
    let pages: Int
    let releaseDate, dedication, summary: String
    let wiki: String
    let chapters: [Chapter]

    enum CodingKeys: String, CodingKey {
        case title, author, pages
        case releaseDate = "release_date"
        case dedication, summary, wiki, chapters
    }
}

// MARK: - Chapter
struct Chapter: Decodable {
    let title: String
}
