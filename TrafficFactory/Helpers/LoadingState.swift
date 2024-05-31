//
//  LoadingState.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

enum LoadingState<Value> {
    case idle
    case loading
    case failure(Error)
    case loaded(Value)

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    var isFinished: Bool { !isLoading }

    var isFailure: Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }

    var value: Value? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }

    var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }

    func map<NewValue>(_ transform: (Value) -> NewValue) -> LoadingState<NewValue> {
        switch self {
        case .idle:
            return .idle
        case .loading:
            return .loading
        case let .failure(error):
            return .failure(error)
        case let .loaded(value):
            return .loaded(transform(value))
        }
    }

    func flatMap<NewValue>(_ transform: (Value) -> LoadingState<NewValue>) -> LoadingState<NewValue> {
        switch self {
        case .idle:
            return .idle
        case .loading:
            return .loading
        case let .failure(error):
            return .failure(error)
        case let .loaded(value):
            return transform(value)
        }
    }
}

extension LoadingState: Equatable where Value: Equatable {
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case let (.loaded(valueL), .loaded(valueR)): return valueL == valueR
        case (.loading, .loading): return true
        case (.idle, .idle): return true
        default: return false
        }
    }
}
