//
//  ItemService.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit

protocol ItemsService {
    func loadItems(completion: @escaping (Result<[ItemViewModel], AppError>) -> Void)
}

/// Helper extension for caching mechanism to fall back to `API` call in case caching load fails.
extension ItemsService {
    func fallback(_ fallback: ItemsService) -> ItemsService {
        ItemServiceWithFallBack(primary: self, fallback: fallback)
    }
    
    func retry(_ retryCount: UInt) -> ItemsService {
        var service: ItemsService = self
        for _ in 0..<retryCount {
            service = service.fallback(self)
        }
        return service
    }
}

struct ItemServiceWithFallBack: ItemsService {
    let primary:  ItemsService
    let fallback: ItemsService
    
    func loadItems(completion: @escaping (Result<[ItemViewModel], AppError>) -> Void) {
        primary.loadItems { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                fallback.loadItems(completion: completion)
            }
        }
    }
}

protocol DetailService {
    func loadDetailItem(using name: String, completion: @escaping (Result<[SchoolDetail], AppError>) -> Void)
}
