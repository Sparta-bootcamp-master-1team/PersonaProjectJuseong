//
//  DataService.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//


import Foundation

final class DataService {
    
    enum DataError: Error {
        case fileNotFound
        case dataConversionFailed
        case parsingFailed
    }
    
    static func loadBooks() async throws -> [Attributes] {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            throw DataError.fileNotFound
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            throw DataError.dataConversionFailed
        }
        
        guard let bookResponse = try? JSONDecoder().decode(BookResponse.self, from: data) else {
            throw DataError.parsingFailed
        }
        
        let books = bookResponse.data.map { $0.attributes }
        return books
    }
}
