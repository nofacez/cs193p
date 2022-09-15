//
//  ContentView.swift
//  Memorize
//
//  Created by Mikhail on 30.08.2022.
//

import SwiftUI


struct ContentView: View {
    @State var currentTheme = "animals"
    // Essentialy it says: "Rerender view Everytime ObservedObject is changed" 
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize \(viewModel.theme.name)!")
                .font(.title)
            Text("Score: \(viewModel.score)")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
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
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 5)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
    }
}
