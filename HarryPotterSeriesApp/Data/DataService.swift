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
        case parsingFailed
    }
    
    static func loadBooks(completion: (Result<[Attributes], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}
