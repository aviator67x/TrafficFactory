//
//  CachedImage.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 31.05.2024.
//

import Foundation

final class CachedImage {
    let imageData: Data

    init(image: Data) {
        self.imageData = image
    }
}
