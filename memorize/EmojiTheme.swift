//
//  ThemeModel.swift
//  Memorize
//
//  Created by Mikhail on 13.09.2022.
//

import Foundation


struct ThemeModel {
    let themes = [
        ThemeModel.Theme(name: "Animals", emojis: [ "🐍", "🐥", "🦆", "🦀", "🐛", "🦕", "🕸", "🐫", "🐬", "🕷", "🐌", "🐒"], numberOfPairs: 12, color: "purple"),
        ThemeModel.Theme(name: "Weather", emojis:  ["🌧", "❄️", "🌕", "🌟", "☃️", "🌦", "⛈", "🌩", "☔️", "☂️", "🌈"], numberOfPairs: 9, color: "blue"),
        ThemeModel.Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚌", "🚙", "🚎", "🏎", "🚜", "🚃"], numberOfPairs: 8, color: "pink"),
        ThemeModel.Theme(name: "Flags", emojis: ["🏴‍☠️", "🇦🇿", "🇩🇿", "🇦🇲", "🇦🇷", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇧🇷"], numberOfPairs: 10, color: "orange")
    ]
    private(set) var currentTheme: Theme
    
    init() {
        currentTheme = themes.randomElement() ?? themes[0]
    }
     
    mutating func getRandomTheme() {
        currentTheme = themes.randomElement() ?? themes[0]
    }
    
    struct Theme {
        var name: String
        var emojis: Array<String>
        var numberOfPairs: Int
        var color: String
    }
}
