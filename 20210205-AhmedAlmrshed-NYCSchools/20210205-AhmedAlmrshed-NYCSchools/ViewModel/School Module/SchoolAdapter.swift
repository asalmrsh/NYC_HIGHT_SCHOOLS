//
//  SchoolAdapter.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

struct SchoolAdapter: ItemsService {
    let schoolAPI: SchoolAPI
    let select: (School) -> Void
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], AppError>) -> Void) {
        schoolAPI.loadSchools { result in
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
