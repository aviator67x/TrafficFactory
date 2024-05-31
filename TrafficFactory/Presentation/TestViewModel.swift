//
//  TestViewModel.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

final class TestVeiwModel: ObservableObject {
    // MARK: - private properties

    private let objectsLoader: ObjectsLoadable = ObjectsLoader()
    private let cacher = Cacher()
    private let imagesLoader: ImagesLoadable
    
    // MARK: - published properties

    @Published var state: LoadingState<[ObjectModel]> = .idle
    @Published var imageState: LoadingState<Data> = .loading
    
    // MARK: - life cycle

    init() {
        imagesLoader = ImagesLoader(cacher: cacher)
        getObjects()
    }
    
    func getObjects() {
        state = .loading
        objectsLoader.loadObjects(from: "https://496.ams3.cdn.digitaloceanspaces.com/data/test.json") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(objects):
                    let objectModels = objects.map {
                        ObjectModel(object: $0,
                                    imageLoader: self.imagesLoader)
                    }
                    self.state = .loaded(objectModels)
                    
                case let .failure(error):
                    self.state = .failure(error)
                }
            }
        }
    }
}
