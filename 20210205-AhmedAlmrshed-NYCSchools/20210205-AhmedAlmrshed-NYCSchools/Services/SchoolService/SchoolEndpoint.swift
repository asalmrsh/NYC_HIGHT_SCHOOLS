//
//  SchoolEndpoint.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/7/22.
//

import Foundation

struct SchoolEndpoint {
    struct SchoolListEndpoint: Endpoint {
        var baseURL: URL {
            return URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
        }
                
        var httpMethod: HTTPMethod {
            return .get
        }
                
        var request: URLRequest {
            var request = URLRequest(url: baseURL)
            request.httpMethod = httpMethod.rawValue
            
            request.setValue(
                HTTPHeaderValue.applicationJson.rawValue,
                forHTTPHeaderField: HTTPHeaderField.accept.rawValue
            )
            request.setValue(
                "JQK7pa5gF9K80pfp7IvrzlCqc",
                forHTTPHeaderField: HTTPHeaderField.appToken.rawValue
            )
            return request
        }
    }
    
    struct SchoolDetailEndpoint: Endpoint {
        let schoolName: String
        
        var baseURL: URL {
            return URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!
        }
                
        var httpMethod: HTTPMethod {
            return .get
        }
        
        var urlQueryItem: [URLQueryItem]? {
            return [URLQueryItem(name: "school_name", value: schoolName)]
        }
        
        var request: URLRequest {
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            components.queryItems = self.urlQueryItem
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = httpMethod.rawValue
            
            request.setValue(
                HTTPHeaderValue.applicationJson.rawValue,
                forHTTPHeaderField: HTTPHeaderField.accept.rawValue
            )
            request.setValue(
                "JQK7pa5gF9K80pfp7IvrzlCqc",
                forHTTPHeaderField: HTTPHeaderField.appToken.rawValue
            )
            return request
        }
    }
}
