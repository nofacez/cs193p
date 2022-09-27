//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Mikhail on 05.09.2022.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private var themeModel: ThemeModel
    @Published private var model: MemoryGame<String>

    
    private static func createMemoryGame(theme: ThemeModel.Theme) -> MemoryGame<String> {
        var numberOfPairs = theme.numberOfPairs
        if theme.numberOfPairs > theme.emojis.count {
            numberOfPairs = theme.emojis.count
        }
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) {
            pairIndex in theme.emojis[pairIndex]
        }
    }
    
    
    init() {
        themeModel = ThemeModel()
        model = EmojiMemoryGame.createMemoryGame(theme: themeModel.currentTheme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var theme: ThemeModel.Theme {
        themeModel.currentTheme
    }
    
    var themeColor: Color {
        switch themeModel.currentTheme.color {
        case "orange":
            return Color.orange
        case "pink":
            return Color.pink
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        default:
            return Color.green
        }
        
    }
    
    var score: Int {
        model.score
    }
    
    
    
    // MARK: - Intent(s)
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        themeModel.getRandomTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: themeModel.currentTheme)
    }
 }
