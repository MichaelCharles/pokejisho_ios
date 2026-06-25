import SwiftUI
import VisionKit
import PokeJishoKit

/// Shows a captured photo with a Live Text selection overlay. On Search, the
/// selected text is normalized and handed up via `onSearch`.
struct TextSelectionView: View {
    let image: UIImage
    let onSearch: (String) -> Void
    let onCancel: () -> Void

    @EnvironmentObject var loc: LocalizationManager
    @State private var interaction = ImageAnalysisInteraction()
    @State private var showEmptyAlert = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()
                LiveTextImageView(image: image, interaction: interaction)
                Text(loc.string("scan.hint"))
                    .font(.footnote)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.bottom, 20)
            }
            .navigationTitle(loc.string("scan.title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(loc.string("common.cancel"), action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(loc.string("scan.search")) {
                        let text = normalizeScannedText(interaction.selectedText)
                        if text.isEmpty {
                            showEmptyAlert = true
                        } else {
                            onSearch(text)
                        }
                    }
                }
            }
            .alert(loc.string("scan.empty"), isPresented: $showEmptyAlert) {
                Button(loc.string("common.ok"), role: .cancel) {}
            }
        }
    }
}
