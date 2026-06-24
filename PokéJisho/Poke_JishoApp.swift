//
//  Poke_JishoApp.swift
//  PokéJisho
//
//  Created by Michael Charles Aubrey on 2026/06/24.
//

import SwiftUI
import PokeJishoKit

@main
struct Poke_JishoApp: App {
    @StateObject private var userData = UserData()
    @StateObject private var loc = LocalizationManager()
    private let store: DictionaryStore

    init() {
        store = (try? DictionaryStore.loadBundled()) ?? DictionaryStore(entries: [])
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
                .environmentObject(userData)
                .environmentObject(loc)
                .tint(.accentColor)
        }
    }
}
