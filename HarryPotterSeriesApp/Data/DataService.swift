//
//  DataService.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 3/27/25.
//

import Foundation

/// JSON 파일을 로드 및 디코딩하여 도서 데이터를 반환
final class DataService {
    
    // MARK: - Error 정의

    /// JSON 로딩 및 파싱 과정 중 발생할 수 있는 에러 타입 정의
    enum DataError: Error {
        case fileNotFound             // JSON 파일을 찾을 수 없는 경우
        case dataConversionFailed     // 파일을 Data로 변환 실패한 경우
        case parsingFailed            // JSON 파싱에 실패한 경우
    }
    
    // MARK: - Methods

    /// "data.json" 파일을 비동기적으로 로드하고 도서 목록 배열로 반환
    static func loadBooks() async throws -> [Attributes] {
        // 파일 경로 탐색
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            throw DataError.fileNotFound
        }
        
        // 파일 → Data 변환
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            throw DataError.dataConversionFailed
        }
        
        // Data → BookResponse 디코딩
        guard let bookResponse = try? JSONDecoder().decode(BookResponse.self, from: data) else {
            throw DataError.parsingFailed
        }
        
        // 필요한 도서 속성만 추출
        let books = bookResponse.data.map { $0.attributes }
        return books
    }
}
