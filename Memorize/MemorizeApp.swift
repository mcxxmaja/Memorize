//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Maja on 27/12/2023.
//

import SwiftUI
import SwiftData

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame(theme: .renovation)
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
