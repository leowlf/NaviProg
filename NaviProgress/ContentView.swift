import SwiftUI

struct ContentView: View {

    @StateObject var avatarVM = AvatarViewModel()
    @State private var goals: [Goal] = []

    var body: some View {
        TabView {
            
            // HOME
            Home(avatarVM: avatarVM, goals: $goals)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // OBJECTIFS
            Objectifs(avatarVM: avatarVM, goals: $goals)
                .tabItem {
                    Label("Objectifs", systemImage: "target")
                }
            
            // TRACKING
            TrackingView(avatarVM: avatarVM, goals: $goals)
                .tabItem {
                    Label("Tracking", systemImage: "square.and.pencil")
                }
        }
        .onAppear {
            avatarVM.speak("Heureux de te revoir ! On continue nos progrès ensemble 🚀")
        }
    }
}

