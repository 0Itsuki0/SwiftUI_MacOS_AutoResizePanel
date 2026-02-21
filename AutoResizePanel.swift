
import SwiftUI

@main
struct AutoResizePanelApp: App {
    var body: some Scene {
        Window("", id: AutoResizePanelView.id) {
            AutoResizePanelView()
        }
    }
}


struct AutoResizePanelView: View {
    static let id = "panel"
    @State private var small: Bool = false
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "star.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: small ? 100 : 200, height: small ? 100 : 200)
            Button(action: {
                withAnimation {
                    small.toggle()
                }
            }, label: {
                Text("Change")
            })
        }
        .onAppear {
            guard let window = NSApplication.shared.windows.first(where: {$0.identifier?.rawValue == Self.id}) else {
                return
            }

            print("window found")
            window.level = .screenSaver // popUpMenu will also work

            // remove title and buttons
            window.styleMask.remove(.titled)
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true

            // so that the window can follow the virtual desktop
            window.collectionBehavior.insert(.canJoinAllSpaces)

            // set it clear here so the configuration in UtilityWindowView will be reflected as it is
            window.backgroundColor = .clear
            
            window.isMovableByWindowBackground = true
        }
    }
}
