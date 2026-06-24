import Foundation

public enum EntryType: String, Codable, CaseIterable, Sendable {
    case pokemon, ability, item, move, nature, character, location

    public init(from decoder: Decoder) throws {
        let raw = try decoder.singleValueContainer().decode(String.self)
        switch raw.lowercased() {
        case "pokémon", "pokemon": self = .pokemon
        case "ability": self = .ability
        case "item": self = .item
        case "move": self = .move
        case "nature": self = .nature
        case "character": self = .character
        case "location": self = .location
        default:
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath,
                debugDescription: "Unknown entry type: \(raw)"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

public struct DictionaryEntry: Codable, Identifiable, Hashable, Sendable {
    public let type: EntryType
    public let english: String
    public let japanese: String
    public let katakana: String
    public let romaji: String

    public var id: String { "\(type.rawValue)|\(english)|\(japanese)" }

    enum CodingKeys: String, CodingKey { case type, english, japanese, katakana, romaji }

    public init(type: EntryType, english: String, japanese: String, katakana: String, romaji: String) {
        self.type = type
        self.english = english
        self.japanese = japanese
        self.katakana = katakana
        self.romaji = romaji
    }
}
