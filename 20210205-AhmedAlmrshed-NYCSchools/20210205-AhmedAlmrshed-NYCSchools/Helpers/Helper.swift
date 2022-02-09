//
//  Helper.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/6/22.
//

import UIKit


public typealias JSONObject = [String: Any]

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case accept      = "Accept"
    case appToken    = "X-App-Token"
    case schoolName  = "school_name"
}

enum HTTPHeaderValue: String {
    case applicationJson = "application/json"
}

protocol Endpoint {
    var baseURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var payload: JSONObject? { get }
    var body: Data? { get }
    var urlQueryItem: [URLQueryItem]? { get }
    var request: URLRequest { get }
}
extension Endpoint {
    var payload: JSONObject? { return nil }
    var body: Data? { return nil }
    var urlQueryItem: [URLQueryItem]? { return nil }
}



struct DisplaiableError {
    let code: String
    let description: String
}

enum CustomType {
    case dataConverstionIssue
    case invalidResponse
    case unsupportedDevice
    case unknow(error: String?)
}

enum AppError: Error {
    case generic(_ error: DisplaiableError)
    case os(error: Error)
    case custom(type: CustomType)
}


extension DispatchQueue {
    static func mainAsyncIfNeeded(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            main.async(execute: work)
        }
    }
}

extension UIViewController {
    var presenterVC: UIViewController {
        parent?.presenterVC ?? parent ?? self
    }
    
    func show(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.showDetailViewController(alert, sender: self)
    }
}

