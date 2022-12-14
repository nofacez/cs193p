//
//  MemoryGame.swift
//  Memorize
//
//  Created by Mikhail on 05.09.2022.
//





import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    var score: Int = 0
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasBeenSeen {
                       score -= 1
                    }
                    if cards[potentialMatchIndex].hasBeenSeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp.toggle()

                cards[chosenIndex].hasBeenSeen = true
                cards[potentialMatchIndex].hasBeenSeen = true
            } else {
                indexOfFaceUpCard = chosenIndex
            }
            
        } 
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        var rawCards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            rawCards.append(Card(id: pairIndex*2, content: content))
            rawCards.append(Card(id: pairIndex*2+1, content: content))
        }
        
        cards = rawCards.shuffled()
        score = 0
    }
    
    struct Card: Identifiable {
        let id: Int
        
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
    }
}


extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
