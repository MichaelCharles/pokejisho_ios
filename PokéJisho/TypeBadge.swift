import SwiftUI
import PokeJishoKit

struct TypeBadge: View {
    let type: EntryType
    @EnvironmentObject var loc: LocalizationManager
    var body: some View {
        Text(loc.string("type.\(type.rawValue)"))
            .font(.caption2).bold()
            .padding(.horizontal, 8).padding(.vertical, 3)
            .background(Color.accentColor.opacity(0.25), in: Capsule())
    }
}

struct EntryRow: View {
    let entry: DictionaryEntry
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.english).font(.body)
                Text(entry.japanese).font(.body).foregroundStyle(.secondary)
            }
            Spacer()
            TypeBadge(type: entry.type)
        }
    }
}
