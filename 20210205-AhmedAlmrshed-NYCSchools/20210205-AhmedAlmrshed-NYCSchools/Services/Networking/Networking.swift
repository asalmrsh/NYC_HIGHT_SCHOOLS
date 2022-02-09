//
//  Networking.swift
//  20210205-AhmedAlmrshed-NYCSchools
//
//  Created by Ahmed Almrshed on 2/7/22.
//

import Foundation

// We could use `SessionDelegate` if we need to handle error or data at early stage.
class SessionDelegate: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {}
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {}
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {}
}

class Networking {
    let session: URLSession

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = 360
        
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = true
        }
        session = URLSession(
            configuration: configuration,
            delegate: nil,
            delegateQueue: Foundation.OperationQueue.main
        )
    }
    
    func send(_ request: URLRequest, completion: @escaping (Result<(Data?, URLResponse), AppError>) -> Void) {
        var result: Result<(Data?, URLResponse), AppError>?
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                result = .failure(.os(error: error))
            }
            else {
                if let response = response {
                    if let data = data {
                        result = .success((data, response))
                    }
                    else {
                        result = .success((nil, response))
                    }
                }
                else {
                    result = .failure(AppError.custom(type: .unknow(error: nil)))
                }
            }
            
            DispatchQueue.main.async {
                completion(result!)
            }
        }
        task.resume()
    }
}
