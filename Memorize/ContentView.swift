//
//  ContentView.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}

















#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
