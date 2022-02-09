//
//  SchoolDetailAdapter.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/7/22.
//

import Foundation

struct SchoolDetailAdapter: DetailService {
    let schoolAPI: SchoolAPI
    
    func loadDetailItem(using name: String, completion: @escaping (Result<[SchoolDetail], AppError>) -> Void) {
        schoolAPI.loadSchoolDetail(using: name) { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result)
            }
        }
    }
}
