/// A typealias that combines the `TargetType` and `ResponseDecoder` protocols.
//public typealias RequestType = TargetType & ResponseDecoder
import Foundation

public protocol RequestType: TargetType & ResponseDecoder { }

public extension RequestType {
    /// Performs a network request using a dispatcher with a specified timeout.
    /// - Parameters:
    ///   - seconds: The maximum duration to wait for a response before timing out (default is 10 seconds).
    func perform(_ seconds: TimeInterval = 10, completion: @escaping (Result<ResponseType, NetworkError>) -> Void) {
        withTimeout(seconds, operation: { innerCompletion in
            DefaultNetworkDispatcher().dispatch(self, completion: innerCompletion)
        }, completion: completion)
    }
}


public extension RequestType {
    // Executes an asynchronous operation with a timeout.
    /// - Parameters:
    ///   - seconds: The timeout duration in seconds.
    ///   - operation: The asynchronous operation to perform. It must call the provided inner completion handler when done.
    ///   - completion: The completion handler that returns either the operation result or a timeout error.
    func withTimeout<T>(
        _ seconds: TimeInterval,
        operation: (@escaping (Result<T, NetworkError>) -> Void) -> Void,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let timeoutWorkItem = DispatchWorkItem {
            completion(.failure(NetworkError.timeOutRequest))
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds, execute: timeoutWorkItem)
        
        operation { result in
            timeoutWorkItem.cancel()
            completion(result)
        }
    }
}
