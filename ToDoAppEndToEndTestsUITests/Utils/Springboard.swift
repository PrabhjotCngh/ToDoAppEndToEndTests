//
//  Springboard.swift
//  ToDoAppEndToEndTestsUITests
//
//  Created by M_2195552 on 2023-08-01.
//

import Foundation
import XCTest

class Springboard {
    
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    class func deleteApp() {
        XCUIApplication().terminate()
        springboard.activate()
        
        let appIcon = springboard.icons.matching(identifier: "ToDoAppEndToEndTests").firstMatch
        appIcon.press(forDuration: 1.3)
        
        let _ = springboard.buttons["Remove App"].waitForExistence(timeout: 1.0)
        springboard.buttons["Remove App"].tap()
        
        let deleteButton = springboard.alerts.buttons["Delete App"].firstMatch
        if deleteButton.waitForExistence(timeout: 5.0) {
            deleteButton.tap()
            springboard.alerts.buttons["Delete"].tap()
        }
    }
}
