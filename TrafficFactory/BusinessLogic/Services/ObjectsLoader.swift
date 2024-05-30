//
//  APIService.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

protocol ObjectsLoadable {
    func loadObjects(from url: String, completion: @escaping ([ResponseModel]) -> ())
}

final class ObjectsLoader: ObjectsLoadable {
    func loadObjects(from url: String, completion: @escaping ([ResponseModel]) -> ()) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data else { return }
            do {
                let images = try JSONDecoder().decode([ResponseModel].self, from: data)
                completion(images)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
