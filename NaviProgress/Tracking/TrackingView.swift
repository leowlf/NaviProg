import SwiftUI

struct TrackingView: View {
    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]

    @State private var inputValue = ""
    @State private var selectedGoal: Goal?

    var body: some View {
        VStack(spacing: 20) {

            // 🟦 Avatar en haut
            AvatarHeader(avatarVM: avatarVM)
                .padding(.top, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {

                    // 🟪 Titre
                    Text("Tracking")
                        .font(.largeTitle.bold())
                        .padding(.top, 10)

                    // 🟩 Liste des objectifs
                    ForEach(goals) { goal in
                        GoalSelectorRow(goal: goal, selectedGoal: $selectedGoal)
                    }

                    // 🟧 Entrée utilisateur
                    Text("Entre ta performance du jour")
                        .font(.headline)
                        .padding(.top, 20)

                    TextField("Ex : 4, 12, 500...", text: $inputValue)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                    Button(action: validateInput) {
                        Text("Valider la progression")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            avatarVM.speak("Tu veux travailler sur \(selectedGoal?.title ?? "un objectif") aujourd’hui ? 🤖")
        }
    }

    // MARK: Update du score
    func validateInput() {
        guard let selected = selectedGoal,
              let value = Double(inputValue) else { return }

        if let index = goals.firstIndex(where: { $0.id == selected.id }) {
            goals[index].progressValue += value
        }

        inputValue = ""
        avatarVM.speak("Bien reçu ! Continue comme ça 🚀")
    }
}

