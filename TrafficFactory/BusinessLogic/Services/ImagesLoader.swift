//
//  ImagesLoader.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

protocol ImagesLoadable {
    func getImage(at urlString: String, completion: @escaping (Data) -> ())
    func cancelDownloading()
}

final class ImagesLoader: ImagesLoadable {
    private weak var task: URLSessionTask?

    func getImage(at urlString: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data else { return }
            completion(data)
        }
        task.resume()
        self.task = task
    }

    func cancelDownloading() {
        task?.cancel()
    }
}
