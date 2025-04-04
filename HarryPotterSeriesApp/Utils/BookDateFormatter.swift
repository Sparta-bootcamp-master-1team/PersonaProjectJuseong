//
//  BookDateFormatter.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 4/1/25.
//

import Foundation

// 날짜 형식을 변환하는 유틸리티 구조체
struct BookDateFormatter {
    
    // MARK: - Methods

    /// "yyyy-MM-dd" 형식의 문자열을 "MMMM dd, yyyy" 형식으로 변환하는 함수
    static func formatReleaseDate(from dateString: String) -> String {
        // 입력 날짜 포맷터 설정
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        // 출력 날짜 포맷터 설정
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        
        // 입력 문자열을 Date 객체로 변환 시도
        guard let date = inputFormatter.date(from: dateString) else {
            return "정보 없음" // 파싱 실패 시 기본 메시지 반환
        }
        
        // 변환된 날짜 문자열 반환
        return outputFormatter.string(from: date)
    }
}
