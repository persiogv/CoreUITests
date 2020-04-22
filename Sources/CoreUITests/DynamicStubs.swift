//
//  DynamicStubs.swift
//  CoreUITests
//
//  Created by Pérsio on 21/04/20.
//

import Foundation
import Swifter

public enum HTTPMethod {
    case POST
    case GET
}

public struct HTTPStubInfo {
    let url: String
    let jsonFilename: String
    let method: HTTPMethod
}

public final class DynamicStubs {
    
    // MARK: Properties
    
    let server = HttpServer()
    let initialStubs: [HTTPStubInfo]
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameter initialStubs: All stubs info
    public init(initialStubs: [HTTPStubInfo]) {
        self.initialStubs = initialStubs
    }
    
    // MARK: Public methods
    
    /// Sets up
    public func setUp() {
        setupInitialStubs()
        try? server.start()
    }
    
    /// Tears down
    public func tearDown() {
        server.stop()
    }
    
    public func setupStub(url: String, filename: String, method: HTTPMethod = .GET) {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: filename, ofType: "json")
        let fileUrl = URL(fileURLWithPath: filePath!)
        let data = try! Data(contentsOf: fileUrl, options: .uncached)
        
        let json = dataToJSON(data: data)
        
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.json(json as AnyObject))
        }
        
        switch method  {
        case .GET : server.GET[url] = response
        case .POST: server.POST[url] = response
        }
    }
    
    // MARK: Private methods
    
    private func setupInitialStubs() {
        for stub in initialStubs {
            setupStub(url: stub.url, filename: stub.jsonFilename, method: stub.method)
        }
    }
    
    private func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
