//
//  ThemeType.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 25.05.2024.
//

import Foundation

///Object model for decoding themes fetched from network
struct ThemeType: Identifiable {
    var id: UUID
    let cardColor: ColorRGB
    let cardSymbol: String
    let symbols: [String]
    let title: ThemeTitle
}

extension ThemeType: Codable {
    private enum CodingKeys: String, CodingKey {
      case cardColor = "card_color"
      case cardSymbol = "card_symbol"
      case symbols
      case title
    }
    
    init(from decoder: Decoder) throws {
        self.id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardColor = try container.decode(ColorRGB.self, forKey: .cardColor)
        self.cardSymbol = try container.decode(String.self, forKey: .cardSymbol)
        self.symbols = try container.decode([String].self, forKey: .symbols)
        self.title = try container.decode(ThemeTitle.self, forKey: .title)
    }
}

struct ColorRGB: Codable {
    var blue: Float
    var green: Float
    var red: Float
}

enum ThemeTitle: String, Codable {
    case halloween = "Halloween"
    case ballons = "Ballons"
}
