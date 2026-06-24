import Testing
import Foundation
@testable import PokeJishoKit

@Test func decodesEntryAndMapsType() throws {
    let json = """
    {"type":"Pokémon","english":"Bulbasaur","japanese":"フシギダネ","katakana":"フシギダネ","romaji":"fushigidane"}
    """.data(using: .utf8)!
    let entry = try JSONDecoder().decode(DictionaryEntry.self, from: json)
    #expect(entry.type == .pokemon)
    #expect(entry.english == "Bulbasaur")
    #expect(entry.japanese == "フシギダネ")
}

@Test func decodesAbilityCaseInsensitively() throws {
    let json = #"{"type":"Ability","english":"Stench","japanese":"あくしゅう","katakana":"アクシュウ","romaji":"akushuu"}"#
        .data(using: .utf8)!
    let entry = try JSONDecoder().decode(DictionaryEntry.self, from: json)
    #expect(entry.type == .ability)
}
