//
//  UniversityCacheAdapter.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/8/22.
//

import Foundation

struct UniversityCacheAdapter: ItemsService {
    let schoolCache: SchoolCache
    let select: (School) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], AppError>) -> Void) {
        schoolCache.loadCachedSchool { result in
            DispatchQueue.mainAsyncIfNeeded {
                completion(result.map { items in
                    return items.map { item in
                        ItemViewModel(school: item) {
                            select(item)
                        }
                    }
                })
            }
        }
    }
}
