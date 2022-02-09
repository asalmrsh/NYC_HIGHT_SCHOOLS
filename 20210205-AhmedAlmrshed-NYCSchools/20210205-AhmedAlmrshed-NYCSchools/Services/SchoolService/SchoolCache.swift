//
//  SchoolCache.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/7/22.
//

import Foundation

/// This is a simulation for caching, it doesn't do anything. It's a nice to have feature to prevent API traffic calls when unnecessary.
class SchoolCache {
    private var schools: [School]?
    
    func loadCachedSchool(completion: @escaping (Result<[School], AppError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.25) {
            if let schools = self.schools {
                completion(.success(schools))
            } else {
                completion(.failure(.generic(DisplaiableError(code: "1200", description: "Caching failed"))))
            }
        }
    }

    func save(_ schools: [School]) {
        self.schools = schools
    }
}

