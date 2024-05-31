//
//  ContentView.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import Combine
import SwiftUI

struct TestView: View {
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.gray
                .frame(maxWidth: .infinity)

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
                TestCellView(object: object)
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
        }
    }

    // MARK: - private properties

    @StateObject private var viewModel = TestVeiwModel()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
