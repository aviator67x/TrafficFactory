//
//  CellView.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import SwiftUI

struct CellView: View {
    @ObservedObject private var cellModel: ObjectModel

    var body: some View {
        VStack(alignment: .center) {
            switch cellModel.imageState {
            case .idle:
                Color.green
                    .aspectRatio(contentMode: .fill)

            case let .loaded(data):
                if let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }

            case .loading:
                ProgressView()
                    .scaleEffect(2)
                    .frame(alignment: .center)

            case .failure:
                Text("Can't download image")
            }
        }
    }

    init(object: ObjectModel) {
        self.cellModel = object
    }
}
