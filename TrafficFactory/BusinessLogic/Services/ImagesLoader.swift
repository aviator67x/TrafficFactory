//
//  ImagesLoader.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

protocol ImagesLoadable {
    func getImage(at urlString: String, completion: @escaping (Result<Data, FetchError>) -> ())
    func cancelDownloading()
}

final class ImagesLoader: ImagesLoadable {
    private weak var task: URLSessionTask?
    private let cacher = Cacher()

    func getImage(at urlString: String,
                  completion: @escaping (Result<Data, FetchError>) -> ())
    {
        if let data = cacher.getData(at: urlString as NSString) {
            completion(.success(data))
        } else {
            guard let url = URL(string: urlString) else {
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
                let cachedImage = CachedImage(image: data)
                self.cacher.save(data: cachedImage, with: NSString(string: urlString))
                completion(.success(data))
            }
            task.resume()
            self.task = task
        }
    }

    func cancelDownloading() {
        task?.cancel()
    }
}
