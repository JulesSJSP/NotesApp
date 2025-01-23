//
//  ContentView.swift
//  NotesApp
//
//  Created by chapter 2 on 23/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!").padding().background(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
