//
//  OrientationData.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 26.05.2024.
//

import SwiftUI

/// Data about the view size and whether it is in portrait mode or not
struct OrientationData: Identifiable, Equatable {
    var id: String { "\(size.width)\(size.height)" }
    var isPortrait: Bool { size.width < size.height }
    let size: CGSize
    
    static let empty = OrientationData(size: .zero)
    
    static func == (lhs: OrientationData, rhs: OrientationData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ReadSizeDataPreferenceKey: PreferenceKey {
    typealias Value = OrientationData
    static var defaultValue: OrientationData = .empty
    
    static func reduce(value: inout OrientationData, nextValue: () -> OrientationData) {
        value = nextValue()
    }
}

struct ReadSizeDataEnvironmentKey: EnvironmentKey {
    static let defaultValue: OrientationData = .empty
}

extension EnvironmentValues {
    var orientationData: OrientationData {
        get { self[ReadSizeDataEnvironmentKey.self] }
        set { self[ReadSizeDataEnvironmentKey.self] = newValue }
    }
}

extension View {
    func readOrientationData(onChange: @escaping (OrientationData) -> Void) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear.preference(key: ReadSizeDataPreferenceKey.self, value: OrientationData(size: proxy.size))
            }
            .onPreferenceChange(ReadSizeDataPreferenceKey.self, perform: onChange)
        }
    }
}
