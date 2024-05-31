//
//  CellView.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import SwiftUI

struct TestCellView: View {
    var body: some View {
        VStack(alignment: .center) {
            Group {
                switch cellModel.imageState {
                case .idle:
                    Color.gray

                case let .loaded(data):
                    if let image = UIImage(data: data) {
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                        }
                    }

                case .loading:
                    ProgressView()
                        .scaleEffect(2)

                case .failure:
                    Text("Can't download image")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)

            Text(cellModel.image.title)

            Text(cellModel.image.description)
        }
        .listRowInsets(.init())
        .onAppear {
            cellModel.getImage(url: cellModel.image.imageURL)
        }
        .onDisappear {
            cellModel.stopLoading()
        }
    }

    // MARK: - private properties

    @ObservedObject private var cellModel: ObjectModel

    // MARK: - life cycle

    init(object: ObjectModel) {
        self.cellModel = object
    }
}
