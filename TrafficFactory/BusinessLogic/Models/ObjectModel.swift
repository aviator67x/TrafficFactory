//
//  ImageModel.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

final class ObjectModel: ObservableObject, Identifiable {
    // MARK: - private properties

    private let imageLoader: ImagesLoadable
    
    let id = UUID()
    let image: ResponseModel

    // MARK: - published properties

    @Published private(set) var imageState: LoadingState<Data> = .idle

    // MARK: - life cycle

    init(object: ResponseModel, imageLoader: ImagesLoadable) {
        self.image = object
        self.imageLoader = imageLoader
    }

    func getImage(url: String) {
        imageState = .loading
        imageLoader.getImage(at: url) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.imageState = .loaded(data)

                case let .failure(error):
                    self.imageState = .failure(error)
                }
            }
        }
    }

    func stopLoading() {
        imageState = .idle
        imageLoader.cancelDownloading()
    }
}
