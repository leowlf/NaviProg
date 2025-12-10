import SwiftUI

struct GoalSelectorRow: View {

    var goal: Goal
    @Binding var selectedGoal: Goal?

    var isSelected: Bool {
        selectedGoal?.id == goal.id
    }

    var body: some View {
        HStack {
            Text(goal.icon)
            Text(goal.title)
                .font(.headline)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.15) : Color(.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
            selectedGoal = goal
        }
    }
}

