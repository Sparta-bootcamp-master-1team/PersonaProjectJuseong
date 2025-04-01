//
//  BookDateFormatter.swift
//  HarryPotterSeriesApp
//
//  Created by 박주성 on 4/1/25.
//

import Foundation

struct BookDateFormatter {
    static func formatReleaseDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return "정보 없음"
        }
        
        return outputFormatter.string(from: date)
    }
}
