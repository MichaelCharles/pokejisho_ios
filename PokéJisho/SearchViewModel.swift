import Foundation
import Combine
import PokeJishoKit

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var filter: EntryType?
    @Published private(set) var results = SearchResults(priority: [], results: [])

    private let store: DictionaryStore
    private var cancellables = Set<AnyCancellable>()

    init(store: DictionaryStore) {
        self.store = store
        Publishers.CombineLatest($query, $filter)
            .debounce(for: .milliseconds(120), scheduler: RunLoop.main)
            .sink { [weak self] q, f in
                guard let self else { return }
                self.results = self.store.search(q, filter: f)
            }
            .store(in: &cancellables)
    }

    var hasQuery: Bool { !query.trimmingCharacters(in: .whitespaces).isEmpty }
}
