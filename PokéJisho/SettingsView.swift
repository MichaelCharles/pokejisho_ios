import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var loc: LocalizationManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(loc.string("settings.language")) {
                    Picker(loc.string("settings.language"), selection: Binding(
                        get: { loc.language },
                        set: { loc.language = $0 }
                    )) {
                        Text(loc.string("settings.language.system")).tag(AppLanguage.system)
                        Text("English").tag(AppLanguage.en)
                        Text("日本語").tag(AppLanguage.ja)
                    }
                }
            }
            .navigationTitle(loc.string("settings.title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { dismiss() }
                }
            }
        }
    }
}
