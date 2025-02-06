import SwiftUI
struct Pagina2View: View {
    @Binding var task: Task  // Dit is de Binding naar de taak die we in ContentView hebben doorgegeven
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

#Preview {
    ContentView()
}
