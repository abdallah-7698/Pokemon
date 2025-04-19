import Foundation

/// A protocol for dispatching network requests.
 protocol NetworkDispatcher {
    /// Dispatches a network request and returns the response asynchronously.
    /// - Parameters:
    ///   - request: The network request to dispatch.
    /// - Returns: The response from the network request.
     func dispatch<Request: RequestType>(_ request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void)
}
