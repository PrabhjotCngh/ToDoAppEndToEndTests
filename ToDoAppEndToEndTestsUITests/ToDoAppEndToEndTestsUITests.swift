//
//  ToDoAppEndToEndTestsUITests.swift
//  ToDoAppEndToEndTestsUITests
//
//  Created by M_2195552 on 2023-07-27.
//

import XCTest

final class ToDoAppEndToEndTestsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

class when_app_is_launched: XCTestCase {
    
    func test_should_not_display_any_tasks() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(0, taskList.cells.count)
    }
    
    override class func tearDown() {
        Springboard.deleteApp()
    }
}

class when_user_saves_a_new_task: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    func test_should_be_able_to_display_task_successfully() {
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Lets workout today")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(1, taskList.tables.count)
    }
    
    func test_display_error_message_for_duplicate_title_tasks() {
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Lets workout today")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        titleTextField.tap()
        titleTextField.typeText("Lets workout today")
        
        saveTaskButton.tap()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(1, taskList.cells.count)
        
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "Task is already added")
    }
    
    override class func tearDown() {
        Springboard.deleteApp()
    }
}

class when_user_deletes_a_new_task: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Lets workout today")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    func test_should_delete_task_successfully() {
        let cell = app.tables["taskList"].cells["Lets workout today, Medium"]
        cell.swipeLeft()
        app.tables["taskList"].buttons["Delete"].tap()
        XCTAssertFalse(cell.exists)
    }
    
    override func tearDown() {
        Springboard.deleteApp()
    }
}

class when_user_marks_task_as_favorite: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Lets workout today")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    func test_should_displayed_updated_task_on_screen_as_favorite() {
        app.tables["taskList"].cells["Lets workout today, Medium"].tap()
        app.images["favoriteImage"].tap()
        app.buttons["closeButton"].tap()
        
        XCTAssertTrue(app.tables["taskList"].cells["Lets workout today, Love, Medium"].exists)
    }
    
    override func tearDown() {
        Springboard.deleteApp()
    }
}

