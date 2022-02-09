//
//  UniversityAdapter.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

struct UniversityAdapter: ItemsService {
    let universityAPI: UniversityAPI
    let select: (University) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], AppError>) -> Void) {
        universityAPI.loadUniversities { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result.map { items in
                    return items.map { item in
                        ItemViewModel(university: item) {
                            select(item)
                        }
                    }
                })
            }
        }
    }
}
