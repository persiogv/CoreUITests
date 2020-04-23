//
//  Screen.swift
//  CoreUITests
//
//  Created by Pérsio on 23/12/18.
//

import XCTest

public typealias Element = XCUIElement
public typealias Query = XCUIElementQuery

public struct Queries {
    public static let datePickers = XCUIApplication().datePickers
    public static let pickers = XCUIApplication().pickers
    public static let tables = XCUIApplication().tables
    public static let otherElements = XCUIApplication().otherElements
    public static let staticTexts = XCUIApplication().staticTexts
    public static let buttons = XCUIApplication().buttons
    public static let segmentedControls = XCUIApplication().segmentedControls
    public static let switches = XCUIApplication().switches
    public static let textFields = XCUIApplication().textFields
    public static let images = XCUIApplication().images
    public static let cells = XCUIApplication().cells
    public static let navigationBars = XCUIApplication().navigationBars
}

open class Screen {
    
    // MARK: Properties
    
    public private(set) var feature: Feature
    
    // MARK: Initializer
    
    public required init(feature: Feature) {
        self.feature = feature
    }
    
    // MARK: Public statements
    
    public final func waitForElement(withLabel label: String, query: Query, existence: Bool = true, waiting: TimeInterval = 10, scrolling: Int = 3) -> Element {
        let element = query.element(matching: NSPredicate(format: "label == '\(label)'"))
        
        return waitForElement(element, existence: existence, waiting: waiting, scrolling: scrolling)
    }
    
    public final func waitForElement(withIdentifier identifier: String, query: Query, existence: Bool = true, waiting: TimeInterval = 10, scrolling: Int = 3) -> Element {
        let element = query[identifier]
        
        return waitForElement(element, existence: existence, waiting: waiting, scrolling: scrolling)
    }
    
    public final func isElementHittable(_ element: Element, timeout: TimeInterval = 10) -> Bool {
        feature.expectation(for: NSPredicate(format: "isHittable == 1"), evaluatedWith: element, handler: nil)
        feature.waitForExpectations(timeout: timeout, handler: nil)
        
        return element.isHittable
    }
    
    public final func isElementSelected(_ element: Element, timeout: TimeInterval = 10) -> Bool {
        feature.expectation(for: NSPredicate(format: "isSelected == 1"), evaluatedWith: element, handler: nil)
        feature.waitForExpectations(timeout: timeout, handler: nil)
        
        return element.isSelected
    }
    
    // MARK: Private methods
    
    private func waitForElement(_ element: Element, existence: Bool, waiting: TimeInterval, scrolling: Int) -> Element {
        if element.isVisible && existence { return element }
        if !element.exists && !existence { return element }
        
        if (!element.exists && existence) || (element.exists && !existence) && waiting > 0 {
            let predicate = NSPredicate(format: "exists == \(existence ? "1" : "0")")
            let expectation = feature.expectation(for: predicate, evaluatedWith: element, handler: nil)
            
            feature.wait(for: [expectation], timeout: waiting)
        }
        
        if !element.isVisible && scrolling > 0 && existence {
            var currentAttempt = 0
            
            while !element.isVisible && currentAttempt < scrolling {
                XCUIApplication().swipeUp()
                currentAttempt += 1
            }
            
            while !element.isVisible && (currentAttempt + scrolling) > 0 {
                XCUIApplication().swipeDown()
                currentAttempt -= 1
            }
        }
        
        if !element.isVisible && existence {
            XCTFail("Could not found element: \(element)")
        }
        
        if element.isVisible && !existence {
            XCTFail("Element still exists: \(element)")
        }
        
        return element
    }
}
