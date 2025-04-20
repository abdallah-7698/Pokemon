import Foundation

/// The default implementation of the NetworkDispatcher protocol.
final class DefaultNetworkDispatcher: NetworkDispatcher {
    private let session: URLSessionProtocol

    /// Initializes the DefaultNetworkDispatcher with an optional URLSession instance.
    /// - Parameter session: The URLSession instance to use for network requests. If not provided,
    /// a shared URLSession will be used by default.
    /// This allows for easy mocking of `URLSession` during testing.
    init(session: URLSessionProtocol = URLSession.shared) {
       self.session = session
   }
    
    
    /// Dispatches a network request asynchronously and handles the response.
    /// - Parameter request: The `RequestType` object containing the network request to be executed.
    /// - Parameter completion: The completion handler to be called when the request is finished.
    /// This completion handler provides either the decoded response or an error.
    /// - Throws: `NetworkError.invalidURL`, `NetworkError.unableToComplete`, `NetworkError.invalidData`, or `NetworkError.invalidResponse`.
    func dispatch<Request: RequestType>(_ request: Request, completion: @escaping (Result<Request.ResponseType, NetworkError>) -> Void) {
        do {
            let urlRequest = try request.asURLRequest()
            print("❌ Network request:", urlRequest)
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    completion(.failure(NetworkError.unableToComplete))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                guard  let response = response as? HTTPURLResponse, request.validStatusCode.contains(response.statusCode) else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                do {
                    let decoded = try request.responseDecoder(data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(NetworkError.invalidData))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(NetworkError.invalidURL))
        }
    }
    
}
