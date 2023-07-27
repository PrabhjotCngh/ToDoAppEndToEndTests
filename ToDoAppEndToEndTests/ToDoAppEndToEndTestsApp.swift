//
//  ToDoAppEndToEndTestsApp.swift
//  ToDoAppEndToEndTests
//
//  Created by M_2195552 on 2023-07-27.
//

import SwiftUI

@main
struct ToDoAppEndToEndTestsApp: App {
    let persistenceController = CoreDataManager.shared.persistentContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
