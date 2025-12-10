import SwiftUI

struct TrackingView: View {

    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]

    @State private var inputValue = ""
    @State private var selectedGoalID: UUID? = nil
    @State private var selectedSubGoalID: UUID? = nil

    var body: some View {
        VStack {

            AvatarHeader(avatarVM: avatarVM)
                .padding(.top, 10)

            ScrollView {
                VStack(alignment: .leading, spacing: 25) {

                    Text("Tracking")
                        .font(.largeTitle.bold())

                    Text("Sélectionne un objectif")
                        .font(.headline)

                    // MARK: - Sélection des objectifs parents
                    ForEach(goals) { goal in
                        Button {
                            selectedGoalID = goal.id
                            selectedSubGoalID = nil
                        } label: {
                            GoalSelectorRowSimple(title: goal.title, selected: selectedGoalID == goal.id)
                        }

                        // Sous-objectifs s’il y en a
                        if !goal.subGoals.isEmpty {
                            ForEach(goal.subGoals) { sg in
                                Button {
                                    selectedSubGoalID = sg.id
                                    selectedGoalID = nil
                                } label: {
                                    GoalSelectorRowSimple(
                                        title: "• \(sg.title)",
                                        selected: selectedSubGoalID == sg.id
                                    )
                                    .padding(.leading, 20)
                                }
                            }
                        }
                    }

                    Divider().padding(.vertical, 10)

                    // MARK: - Entrée utilisateur
                    Text("Entre ta performance")
                        .font(.headline)

                    TextField("Ex : 4, 200, 12…", text: $inputValue)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)

                    Button("Valider ma progression") {
                        validateInput()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 10)
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - LOGIC DE MISE À JOUR
    private func validateInput() {
        guard let value = Double(inputValue) else { return }

        // 🔵 Mise à jour d’un SOUS-OBJECTIF
        if let subID = selectedSubGoalID {
            for i in goals.indices {
                if let subIndex = goals[i].subGoals.firstIndex(where: { $0.id == subID }) {

                    // Mettre à jour la valeur
                    goals[i].subGoals[subIndex].progress =
                        min(value / goals[i].subGoals[subIndex].target, 1.0)

                    // Mettre à jour parent
                    goals[i].progress = goals[i].computedProgress

                    avatarVM.speak("Bravo ! Ta progression pour \(goals[i].subGoals[subIndex].title) a été mise à jour 🎉")
                }
            }
        }

        // 🔵 Mise à jour d’un OBJECTIF parent
        else if let parentID = selectedGoalID,
                let index = goals.firstIndex(where: { $0.id == parentID }) {

            goals[index].storedProgressValue += value
            goals[index].progress = min(goals[index].storedProgressValue / goals[index].target, 1.0)

            avatarVM.speak("Bravo ! Ta progression pour \(goals[index].title) a été mise à jour 🎉")
        }

        inputValue = ""
    }
}

// MARK: - SELECTOR ROW (UI)
struct GoalSelectorRowSimple: View {
    var title: String
    var selected: Bool

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if selected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(selected ? Color.blue.opacity(0.15) : Color(.systemGray6))
        .cornerRadius(12)
    }
}

