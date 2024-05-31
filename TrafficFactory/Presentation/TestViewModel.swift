//
//  TestViewModel.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Foundation

final class TestVeiwModel: ObservableObject {
    @Published var state: LoadingState<[ObjectModel]> = .idle
    @Published var imageState: LoadingState<Data> = .loading
    
    private var images: [ResponseModel] = []
    
    var objectsLoader: ObjectsLoadable = ObjectsLoader()
    
    init() {
        getObjects()
    }
    
    func getObjects() {
        state = .loading
        objectsLoader.loadObjects(from: "https://496.ams3.cdn.digitaloceanspaces.com/data/test.json") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(objects):
                    self.images = objects
                    let objectModels = objects.map {
                        ObjectModel(object: $0)
                    }
                    self.state = .loaded(objectModels)
                    
                case let .failure(error):
                    self.state = .failure(error)
                }
            }
        }
    }
}
