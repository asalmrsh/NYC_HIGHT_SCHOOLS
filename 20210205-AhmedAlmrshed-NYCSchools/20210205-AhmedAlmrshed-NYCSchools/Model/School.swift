//
//  School.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import Foundation

struct School: Decodable {
    let name: String
    let phoneNumber: String
    let totalStudents: String
    let neighborhood: String
    let location: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case name = "school_name"
        case phoneNumber = "phone_number"
        case totalStudents = "total_students"
        case neighborhood
        case location
        case website
    }
}
