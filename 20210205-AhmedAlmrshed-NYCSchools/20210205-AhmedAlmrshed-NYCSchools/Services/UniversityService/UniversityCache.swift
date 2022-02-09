//
//  UniversityCache.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

/// This is a simulation for caching, it doesn't do anything. It's a nice to have feature to prevent API traffic calls when unnecessary.
class UniversityCache {
    private var univeristies: [University]?
    
    func loadCachedUniversity(completion: @escaping (Result<[University], AppError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.25) {
            if let univeristies = self.univeristies {
                completion(.success(univeristies))
            } else {
                completion(.failure(.generic(DisplaiableError(code: "1200", description: "Caching failed"))))
            }
        }
    }

    func save(_ universities: [University]) {
        self.univeristies = universities
    }
}

