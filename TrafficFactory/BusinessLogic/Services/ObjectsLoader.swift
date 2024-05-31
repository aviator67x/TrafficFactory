//
//  APIService.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case failedRequest(Error)
    case failedDecoding
}

protocol ObjectsLoadable {
    func loadObjects(from url: String, completion: @escaping (Result<[ResponseModel], FetchError>) -> ())
}

final class ObjectsLoader: ObjectsLoadable {
    func loadObjects(from url: String,
                     completion: @escaping (Result<[ResponseModel], FetchError>) -> ())
    {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.failedRequest(error)))
            }
            guard let data else {
                return
            }
            do {
                let objects = try JSONDecoder().decode([ResponseModel].self, from: data)
                completion(.success(objects))
            } catch {
                completion(.failure(.failedDecoding))
            }
        }
        task.resume()
    }
}
