import SwiftUI

struct ContentView: View {

    @StateObject var avatarVM = AvatarViewModel()

    // Global goals
    @State private var goals: [Goal] = [
        Goal(title: "Sport", icon: "🏋️‍♂️", type: .quantite, target: 5, unit: "km", frequency: .hebdomadaire, progress: 0.4, storedProgressValue: 2),
        Goal(title: "Lecture", icon: "📚", type: .quantite, target: 30, unit: "pages", frequency: .quotidien, progress: 0.7, storedProgressValue: 21)
    ]

    var body: some View {
        TabView {

            Home(avatarVM: avatarVM, goals: $goals)
                .tabItem { Label("Home", systemImage: "house") }

            Objectifs(avatarVM: avatarVM, goals: $goals)
                .tabItem { Label("Objectifs", systemImage: "target") }

            TrackingView(avatarVM: avatarVM, goals: $goals)
                .tabItem { Label("Tracking", systemImage: "checkmark.circle") }
        }
        .onAppear {
            avatarVM.speak("Bienvenue ! Je suis ton assistant 🤖")
        }
    }
}

