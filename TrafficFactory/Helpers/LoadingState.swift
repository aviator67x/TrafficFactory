//
//  LoadingState.swift
//  TrafficFactory
//
//  Created by Andrew Kasilov on 30.05.2024.
//

public enum LoadingState<Value> {
    case idle
    case loading
    case failure(Error)
    case loaded(Value)

    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    public var isFinished: Bool { !isLoading }

    public var isFailure: Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }

    public var value: Value? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }

    public var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }

    public func map<NewValue>(_ transform: (Value) -> NewValue) -> LoadingState<NewValue> {
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

    public func flatMap<NewValue>(_ transform: (Value) -> LoadingState<NewValue>) -> LoadingState<NewValue> {
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
    public static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.loaded(let valueL), .loaded(let valueR)): return valueL == valueR
        case (.loading, .loading): return true
        case (.idle, .idle): return true
        default: return false
        }
    }
}
