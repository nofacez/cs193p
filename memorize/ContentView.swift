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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                            .foregroundColor(viewModel.themeColor)
                    }
                }
            }
            Spacer()
            Button(action: {
                viewModel.startNewGame()
            }, label: { Text("Start New Game") })
        }
        .padding(.horizontal)
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
        ContentView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
    }
}
