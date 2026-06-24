import SwiftUI
import PokeJishoKit

struct SearchView: View {
    @StateObject private var vm: SearchViewModel
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var loc: LocalizationManager
    @State private var showSettings = false

    init(store: DictionaryStore) {
        _vm = StateObject(wrappedValue: SearchViewModel(store: store))
    }

    var body: some View {
        NavigationStack {
            Group {
                if !vm.hasQuery {
                    HelpView(recents: userData.recents) { vm.query = $0 }
                } else if vm.results.isEmpty {
                    NoResultsView()
                } else {
                    resultsList
                }
            }
            .navigationTitle(loc.string("app.name"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { filterMenu }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showSettings = true } label: { Image(systemName: "gearshape") }
                }
            }
            .sheet(isPresented: $showSettings) { SettingsView() }
        }
        .searchable(text: $vm.query, prompt: loc.string("search.placeholder"))
    }

    private var filterMenu: some View {
        Menu {
            Button {
                vm.filter = nil
            } label: {
                Label("All", systemImage: vm.filter == nil ? "checkmark" : "")
            }
            ForEach(EntryType.allCases, id: \.self) { type in
                Button {
                    vm.filter = type
                } label: {
                    Label(loc.string("type.\(type.rawValue)"),
                          systemImage: vm.filter == type ? "checkmark" : "")
                }
            }
        } label: {
            Image(systemName: vm.filter == nil ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
        }
    }

    private var resultsList: some View {
        List {
            if !vm.results.priority.isEmpty {
                Section {
                    ForEach(vm.results.priority) { row($0) }
                }
            }
            if !vm.results.results.isEmpty {
                Section {
                    ForEach(vm.results.results) { row($0) }
                }
            }
        }
        .listStyle(.plain)
    }

    private func row(_ entry: DictionaryEntry) -> some View {
        NavigationLink {
            DetailView(entry: entry)
                .onAppear { userData.addRecent(vm.query) }
        } label: {
            EntryRow(entry: entry)
        }
    }
}

struct HelpView: View {
    let recents: [String]
    let onSelectRecent: (String) -> Void
    @EnvironmentObject var loc: LocalizationManager

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image("Mascot")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                Text(loc.string("help.welcome")).font(.headline)
                Text(loc.string("help.body"))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                if !recents.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(loc.string("recent.title"))
                            .font(.caption).bold()
                            .foregroundStyle(.secondary)
                        ForEach(recents, id: \.self) { term in
                            Button {
                                onSelectRecent(term)
                            } label: {
                                HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                    Text(term)
                                    Spacer()
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                }
            }
            .padding()
        }
    }
}

struct NoResultsView: View {
    @EnvironmentObject var loc: LocalizationManager
    var body: some View {
        ContentUnavailableView {
            Label(loc.string("results.none.title"), systemImage: "magnifyingglass")
        } description: {
            Text(loc.string("results.none"))
        }
    }
}
