import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var completed: Bool
    var description: String?
}

class TaskModel: ObservableObject {
    @Published var listItems: [Task] = []
    
    func addItem(name: String) {
        let newTask = Task(name: name, completed: false, description: "")
        listItems.append(newTask)
    }
    
    func deleteItem(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: Task) {
        if let index = listItems.firstIndex(where: { $0.id == task.id }) {
            listItems[index].completed.toggle()
        }
    }
    
    func updateItem(task: Task, newName: String, newDescription: String, newCompletedStatus: Bool) {
        if let index = listItems.firstIndex(where: { $0.id == task.id }) {
            listItems[index].name = newName
            listItems[index].description = newDescription
            listItems[index].completed = newCompletedStatus
        }
    }
}

struct ContentView: View {
    @State private var item: String = ""
    @ObservedObject var taskModel = TaskModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Notities")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding([.top, .horizontal])
                
                // TextField voor toevoegen
                HStack {
                    TextField("Add an Item", text: $item)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    
                    Button(action: {
                        if !item.isEmpty {
                            taskModel.addItem(name: item)
                            item = ""
                        }
                    }) {
                        Text("Add")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
                
                // Lijst met taken
                List {
                    ForEach(taskModel.listItems.indices, id: \.self) { index in
                        NavigationLink(destination: Pagina2View(task: $taskModel.listItems[index])) {
                            HStack {
                                // Hier geen checkmark meer tonen
                                Text(taskModel.listItems[index].name)
                                    .font(.headline)
                                    .strikethrough(taskModel.listItems[index].completed, color: .gray)
                                    .foregroundColor(taskModel.listItems[index].completed ? .gray : .primary)
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 5)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                            }
                        }
                    }
                    .onDelete(perform: taskModel.deleteItem)
                }
                
            }
        }
    }
    
    struct pagina2View: View {
        @Binding var task: Task  // Binding naar de taak die we willen bewerken
        @State private var taskName: String
        @State private var taskDescription: String
        @State private var taskCompleted: Bool
        
        init(task: Binding<Task>) {
            _task = task
            _taskName = State(initialValue: task.wrappedValue.name)
            _taskDescription = State(initialValue: task.wrappedValue.description ?? "")
            _taskCompleted = State(initialValue: task.wrappedValue.completed)
        }
        
        var body: some View {
            VStack {
                Form {
                    Section(header: Text("Task Details")) {
                        // Taaknaam bewerken
                        TextField("Task Name", text: $taskName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        // Taak beschrijving bewerken
                        TextEditor(text: $taskDescription)
                            .frame(height: 150)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.bottom)
                        
                        // Voltooid toggle
                        Toggle(isOn: $taskCompleted) {
                            Text("Completed")
                        }
                        .padding(.vertical)
                    }
                    
                    Section {
                        Button(action: {
                            // Werk de taak bij met de nieuwe waarden
                            task.name = taskName
                            task.description = taskDescription
                            task.completed = taskCompleted
                        }) {
                            Text("Save Changes")
                                .font(.headline)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                }
                .navigationTitle("Edit Task")
            }
            .background(Color(UIColor.systemGroupedBackground)) // Achtergrondkleur voor de editor
        }
    }
}
    
    #Preview {
        ContentView()
    }

