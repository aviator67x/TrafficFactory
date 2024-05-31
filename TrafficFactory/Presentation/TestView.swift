//
//  ContentView.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Combine
import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestVeiwModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.yellow

        case .loading:
            ProgressView()
                .scaleEffect(5)

        case .failure:
            Button(action: {
                viewModel.getObjects()
            }) {
                Text("Reload table")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .frame(width: 200, height: 50)

        case let .loaded(objects):
            List(objects) { object in
                VStack {
                    CellView(object: object)
                    Text(object.image.title)
                    Text(object.image.description)
                }
                .listRowInsets(.init())
                .onAppear {
                    object.imageState = .loading
                    object.getImage(url: object.image.imageURL)
                }
                .onDisappear {
                    object.imageState = .idle
                    object.stopLoading()
                }
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
