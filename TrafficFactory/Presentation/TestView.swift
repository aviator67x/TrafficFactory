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
            Button("Reload table") {
                viewModel.getObjects()
            }
            
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


