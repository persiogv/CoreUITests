//
//  Element+Extensions.swift
//  CoreUITests
//
//  Created by Pérsio on 23/12/18.
//

import XCTest

extension Element {
    
    /// Visibility flag
    public var isVisible: Bool {
        return exists && !frame.isEmpty && XCUIApplication().windows.element(boundBy: .zero).frame.contains(frame)
    }
}
