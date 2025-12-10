import SwiftUI

struct Objectifs: View {

    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]

    var body: some View {
        VStack {

            // --- AVATAR EN HAUT ---
            AvatarOverlay(avatarVM: avatarVM)
                .padding(.top, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("Objectifs")
                        .font(.largeTitle.bold())

                    ForEach(goals) { goal in
                        GoalRow(goal: goal)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal)
            }
        }
        .onAppear {
            avatarVM.speak("Voici la liste de tes objectifs 🎯")
        }
    }
}

