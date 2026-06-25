import Testing
@testable import PokeJishoKit

@Test func loadsAll5967Entries() throws {
    let store = try DictionaryStore.loadBundled()
    #expect(store.entries.count == 5967)
}

@Test func containsKnownPokemon() throws {
    let store = try DictionaryStore.loadBundled()
    #expect(store.entries.contains { $0.english == "Pikachu" && $0.type == .pokemon })
}
