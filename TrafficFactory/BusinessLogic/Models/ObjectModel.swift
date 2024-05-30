//
//  ImageModel.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

final class ObjectModel: ObservableObject, Identifiable {
    let id = UUID()
    let image: ResponseModel
    @Published var imageState: LoadingState<Data> = .idle
    private let imageLoader: ImagesLoadable = ImagesLoader()

    init(object: ResponseModel) {
        self.image = object
    }

    func getImage(url: String) {
        imageLoader.getImage(at: url) { data in
            DispatchQueue.main.async {
                self.imageState = .loaded(data)
            }
        }
    }

    func stopLoading() {
        imageLoader.cancelDownloading()
    }
}
