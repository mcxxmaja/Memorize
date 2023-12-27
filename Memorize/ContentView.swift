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
        return RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 3.0)
            .padding(.horizontal)
            .foregroundColor(.red)
    }
}

















#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
