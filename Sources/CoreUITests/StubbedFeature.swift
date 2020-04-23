//
//  StubbedFeature.swift
//  CoreUITests
//
//  Created by Pérsio on 23/04/20.
//

import XCTest

open class StubbedFeature: Feature {
    
    // MARK: Properties
    
    open var dynamicStubs: DynamicStubs {
        DynamicStubs(initialStubs: [])
    }
    
    // MARK: Method overrides
    
    public override func setUp() {
        dynamicStubs.setUp()
        super.setUp()
    }
    
    public override func tearDown() {
        dynamicStubs.tearDown()
        super.tearDown()
    }
}
