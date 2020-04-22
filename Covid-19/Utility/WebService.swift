//
//  WebService.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import Foundation

class WebService {
    func getRequest<T: Decodable>(from urlString: String, dispatchGroup: DispatchGroup, completion: @escaping(Result<T, NetworkError>) -> Void) {
        // check the URL is OK, otherwise return with a failure
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(.error("Bad URL. Please try again."))))
            return
        }
        
        dispatchGroup.enter()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    let response = try? JSONDecoder().decode(T.self, from: data)
                    if let response = response {
                        print(response)
                        completion(.success(response))
                        dispatchGroup.leave()
                    }
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed(.error("Network failure. Please try again."))))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown(.error("Unknown Error. Please try again."))))
                }
            }
        }.resume()
    }
    
    func getRequest<T: Decodable>(from urlString: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        // check the URL is OK, otherwise return with a failure
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(.error("Bad URL. Please try again."))))
            return
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    let response = try? JSONDecoder().decode(T.self, from: data)
                    if let response = response {
                        print(response)
                        completion(.success(response))
                    } else {
                        completion(.failure(.requestFailed(.error("Unknown Error. Please try again."))))
                    }
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed(.error("Network failure. Please try again."))))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown(.error("Unknown Error. Please try again."))))
                }
            }
        }.resume()
    }
}
