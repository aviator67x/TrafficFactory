//
//  ContentView.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
