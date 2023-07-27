//
//  TaskDetailView.swift
//  ToDoAppEndToEndTests
//
//  Created by M_2195552 on 2023-07-27.
//

import SwiftUI

struct TaskDetailView: View {
    //MARK: - Properties
    let task: Task
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var isFavorite: Bool = false
    
    var fetchRequest: FetchRequest<Task>
    
    init(task: Task) {
        self.task = task
        fetchRequest = FetchRequest(entity: Task.entity(), sortDescriptors: [], predicate: NSPredicate(format: "SELF = %@", task), animation: nil)
    }
    
    //MARK: - Functions
    private func updateTask() {
        do {
            let existingTask = try viewContext.existingObject(with: task.objectID) as! Task
            existingTask.isFavorite = isFavorite
            try viewContext.save()
            
        } catch {
            print(error)
        }
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if let existingTask = fetchRequest.wrappedValue.first {
                    Text(existingTask.title ?? "")
                    Image(systemName: task.isFavorite ? "heart.fill": "heart")
                        .accessibilityIdentifier("favoriteImage")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 50)
                        .font(.largeTitle)
                        .onTapGesture {
                            isFavorite = !task.isFavorite
                            updateTask()
                        }
                }
                
                Spacer()
            } //: VStack
            .padding()
            .navigationTitle(task.title ?? "")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // action
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Close")
                            .accessibilityIdentifier("closeButton")
                    }
                    
                }
            } //: toolbar
        } //: NavigationView
    }
}

//MARK: - Preview
struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let task = Task(context: viewContext)
        task.title = "Mow the lawn"
        task.body = "I need to mow the lawn"
        task.priority = "High"
        task.isFavorite = false
        
        return TaskDetailView(task: task)
    }
}
