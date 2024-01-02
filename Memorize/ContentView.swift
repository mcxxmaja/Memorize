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
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3.0)
            Text("Hello world")
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}





































#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
