//
//  Feature.swift
//  CoreUITests
//
//  Created by Pérsio on 23/07/18.
//

import XCTest

open class Feature: XCTestCase {
    
    // MARK: Typealiases
    
    public typealias Operation = () -> Void
    
    // MARK: Overriding
    
    public override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
    }

    // MARK: Public methods
    
    public func given(_ description: String, operation: Operation) {
        addOperation(operation, named: "Given \(description)")
    }
    
    public func and(_ description: String, operation: Operation) {
        addOperation(operation, named: "And \(description)")
    }

    public func when(_ description: String, operation: Operation) {
        addOperation(operation, named: "When \(description)")
    }
    
    public func then(_ description: String, operation: Operation) {
        addOperation(operation, named: "Then \(description)")
    }
    
    // MARK: Private

    private func addOperation(_ operation: Operation, named: String) {
        XCTContext.runActivity(named: named) { (_) in operation() }
    }
}
