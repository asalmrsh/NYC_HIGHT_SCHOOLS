//
//  SchoolDetail.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/7/22.
//

import Foundation

struct SchoolDetail: Decodable {
    let name: String
    let satReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String

    enum CodingKeys: String, CodingKey {
        case name = "school_name"
        case satReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

