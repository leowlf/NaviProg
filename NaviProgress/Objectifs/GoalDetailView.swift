import SwiftUI

struct GoalDetailView: View {
    
    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goal: Goal
    
    @State private var editing = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            AvatarHeader(avatarVM: avatarVM)
                .padding(.top, 12)
            
            Text(goal.title)
                .font(.largeTitle.bold())
                .padding(.top, 5)
            
            Text("Progression : \(Int(goal.computedProgress * 100))%")
                .font(.headline)
                .foregroundColor(.blue)
            
            Divider()
                .padding(.vertical, 10)
            
            if goal.subGoals.isEmpty {
                Text("Aucun sous-objectif")
                    .foregroundColor(.secondary)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(goal.subGoals.indices, id: \.self) { i in
                            SubGoalRow(subGoal: $goal.subGoals[i])
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .onAppear {
            avatarVM.speak("Voici les détails de \(goal.title) 📈")
        }
    }
}

struct SubGoalRow: View {
    
    @Binding var subGoal: SubGoal
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            TextField("Nom du sous-objectif", text: $subGoal.title)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Text("Progression :")
                Spacer()
                Text("\(Int(subGoal.progress * 100))%")
            }
            .font(.subheadline)
            
            TextField("Cible", value: $subGoal.target, format: .number)
                .textFieldStyle(.roundedBorder)
            
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

