//
//  ImagesLoader.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

protocol ImagesLoadable {
    func getImage(at urlString: String,
                  completion: @escaping (Result<Data, FetchError>) -> ())
    func cancelDownloading()
}

final class ImagesLoader: ImagesLoadable {
    // MARK: - private properties

    private weak var task: URLSessionTask?
    private let cacher: Cachable

    // MARK: - life cycle

    init(cacher: Cachable) {
        self.cacher = cacher
    }

    func getImage(at urlString: String,
                  completion: @escaping (Result<Data, FetchError>) -> ())
    {
        if let data = cacher.getData(at: urlString as NSString) {
            completion(.success(data))
        } else {
            guard let url = URL(string: urlString) else {
                return completion(.failure(.invalidURL))
            }

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error {
                    completion(.failure(.failedRequest(error)))
                }
                guard let data else {
                    return completion(.failure(.noData))
                }

                let cachedImage = CachedImage(image: data)
                self?.cacher.save(data: cachedImage, with: NSString(string: urlString))
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
