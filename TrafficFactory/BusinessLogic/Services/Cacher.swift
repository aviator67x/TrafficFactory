//
//  Cacher.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 31.05.2024.
//

import Foundation

protocol Cachable {
    func save(data: CachedImage, with id: NSString)
    func getData(at id: NSString) -> Data?
}

final class Cacher: Cachable {
    private let cache = NSCache<NSString, CachedImage>()

    func save(data: CachedImage, with id: NSString) {
        cache.setObject(data, forKey: id)
    }

    func getData(at id: NSString) -> Data? {
        guard let cachedVersion = cache.object(forKey: id) else {
            return nil
        }
        return cachedVersion.imageData
    }
}
