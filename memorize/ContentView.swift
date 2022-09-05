//
//  ContentView.swift
//  Memorize
//
//  Created by Mikhail on 30.08.2022.
//

import SwiftUI


let emojisDict = [
    "animals": [ "🐍", "🐥", "🦆", "🦀", "🐛", "🦕", "🕸", "🐫", "🐬", "🕷", "🐌"],
    "weather": ["🌧", "❄️", "🌕", "🌟", "☃️", "🌦", "⛈", "🌩", "☔️", "☂️", "🌈"],
    "cars":  ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚜", "🚃", "🛺", "🚔", "🚑"]
]

struct ContentView: View {
    @State var currentTheme = "animals"

    func getCardWidth(cardCount: Int) -> CGFloat {
        let width = UIScreen.main.bounds.width
        return CGFloat(Int(width) / cardCount * 2)
    }
    
    var body: some View {
        let emojiCount = Int.random(in: 8..<11)
        let cardWidth = getCardWidth(cardCount: emojiCount)
        
        VStack {
            Text("Memorize!")
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
                    ForEach(
                        (emojisDict[currentTheme]?[0...emojiCount])!, id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.purple)
            Spacer()
            HStack(alignment: .bottom, spacing: 20) {
                Button {
                    currentTheme = "animals"
                } label: {
                    ThemeLabelView(image: "ladybug.fill", text: "Animals")
                }
                
                Button {
                    currentTheme = "weather"
                } label: {
                    ThemeLabelView(image: "sun.min", text: "Weather")
                }
                
                Button {
                    currentTheme = "cars"
                } label: {
                    ThemeLabelView(image: "car.fill", text: "Cars")
                }
            }
            
        }
        .padding(.horizontal)
        
    }
}

struct ThemeLabelView: View {
    var image: String
    var text: String
    
    var body: some View {
        VStack() {
            Image(systemName: image)
            Text(text)
        }.font(.title2)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
