import SwiftUI

struct Objectifs: View {
    
    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]
    
    @State private var showAddGoal: Bool = false
    @State private var selectedGoalIndex: Int? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            
            // AVATAR EN HAUT
            AvatarHeader(avatarVM: avatarVM)
                .padding(.top, 10)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Titre + bouton ajouter
                    HStack {
                        Text("Objectifs")
                            .font(.largeTitle.bold())
                        
                        Spacer()
                        
                        Button {
                            showAddGoal = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Liste des objectifs
                    if goals.isEmpty {
                        Text("Tu n’as encore aucun objectif. Crée-en un pour commencer 🚀")
                            .foregroundColor(.secondary)
                            .padding(.top, 20)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(Array(goals.enumerated()), id: \.element.id) { index, goal in
                                Button {
                                    selectedGoalIndex = index
                                } label: {
                                    GoalCard(
                                        title: "\(goal.icon) \(goal.title)",
                                        percent: goal.progress
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        // Sheet : création d’objectif
        .sheet(isPresented: $showAddGoal) {
            AddGoalView(avatarVM: avatarVM, goals: $goals)
        }
        // Sheet : détail d’un objectif sélectionné
        .sheet(
            isPresented: Binding(
                get: { selectedGoalIndex != nil },
                set: { if !$0 { selectedGoalIndex = nil } }
            )
        ) {
            if let index = selectedGoalIndex {
                GoalDetailView(avatarVM: avatarVM, goal: $goals[index])
            }
        }
        .onAppear {
            avatarVM.speak("Voici la liste de tes objectifs 🎯")
        }
    }
}

