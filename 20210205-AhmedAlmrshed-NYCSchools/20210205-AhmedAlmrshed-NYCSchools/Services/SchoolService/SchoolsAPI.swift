//
//  SchoolsAPI.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import Foundation

class SchoolAPI {
    static var shard = SchoolAPI()
    
    func loadSchools(completion: @escaping (Result<[School], AppError>) -> Void) {
        let schoolListEndpoint = SchoolEndpoint.SchoolListEndpoint()
        Networking().send(schoolListEndpoint.request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success((let data, let response)):
                guard let response = response as? HTTPURLResponse,
                      let data = data else {
                    completion(.failure(.custom(type: .dataConverstionIssue)))
                    return
                }
                switch response.statusCode {
                case 200:
                    do {
                        let schoolList = try JSONDecoder().decode([School].self, from: data)
                        completion(.success(schoolList))
                        return
                    }
                    catch _ {
                        completion(.failure(.custom(type: .dataConverstionIssue)))
                    }
                default:
                    completion(.failure(.custom(type: .invalidResponse)))
                }
            }
        }
    }
    
    func loadSchoolDetail(using name: String, completion: @escaping (Result<[SchoolDetail], AppError>) -> Void) {
        let schoolDetailEndpoint = SchoolEndpoint.SchoolDetailEndpoint(schoolName: name)
        Networking().send(schoolDetailEndpoint.request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success((let data, let response)):
                guard let response = response as? HTTPURLResponse,
                      let data = data else {
                    completion(.failure(.custom(type: .dataConverstionIssue)))
                    return
                }
                switch response.statusCode {
                case 200:
                    do {
                        let schoolDetail = try JSONDecoder().decode([SchoolDetail].self, from: data)
                        completion(.success(schoolDetail))
                        return
                    }
                    catch _ {
                        completion(.failure(.custom(type: .dataConverstionIssue)))
                    }
                default:
                    completion(.failure(.custom(type: .invalidResponse)))
                }
            }
        }
    }
}
