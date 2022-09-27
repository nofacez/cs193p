//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Mikhail on 30.08.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
