//
//  ContentView.swift
//  Memorize
//
//  Created by Mikhail on 30.08.2022.
//

import SwiftUI


struct ContentView: View {
    typealias Card = MemoryGame<String>.Card
    
    // Essentialy it says: "Rerender view Everytime ObservedObject is changed" 
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize \(viewModel.theme.name)!")
                .font(.title)
            Text("Score: \(viewModel.score)")
            AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
                cardView(for: card)
            }
            Spacer()
            Button(action: {
                viewModel.startNewGame()
            }, label: { Text("Start New Game") })
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
                .foregroundColor(viewModel.themeColor)
        }
    }
}

struct CardView: View {
    let card: ContentView.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(
                        startAngle: Angle(degrees: 0-90),
                        endAngle: Angle(degrees: 110-90)
                    ).opacity(0.5).padding(10)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) / 2)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 5
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return ContentView(viewModel: game)
    }
}
