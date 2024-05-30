//
//  View+AspectRatio.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

import SwiftUI

extension View {
    public func framedAspectRatio(_ aspect: CGFloat? = nil, contentMode: ContentMode) -> some View where Self == Image {
        self.resizable()
            .fixedAspectRatio(contentMode: contentMode)
            .allowsHitTesting(false)
    }

    public func fixedAspectRatio(_ aspect: CGFloat? = nil, contentMode: ContentMode) -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(aspect, contentMode: contentMode)
            .clipped()
    }
}
