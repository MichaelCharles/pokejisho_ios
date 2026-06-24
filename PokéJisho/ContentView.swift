//
//  ContentView.swift
//  PokéJisho
//
//  Created by Michael Charles Aubrey on 2026/06/24.
//

import SwiftUI
import PokeJishoKit

struct ContentView: View {
    let store: DictionaryStore
    var body: some View {
        SearchView(store: store)
    }
}
