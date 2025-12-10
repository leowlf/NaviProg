import SwiftUI
import Charts

struct Home: View {

    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]

    // Objectifs filtrés
    var dailyGoals: [Goal]   { goals.filter { $0.frequency == .quotidien } }
    var weeklyGoals: [Goal]  { goals.filter { $0.frequency == .hebdomadaire } }
    var monthlyGoals: [Goal] { goals.filter { $0.frequency == .mensuel } }

    // Moyenne d’un groupe d’objectifs
    func avg(of goals: [Goal]) -> Double {
        guard !goals.isEmpty else { return 0 }
        return goals.map { $0.progress }.reduce(0, +) / Double(goals.count)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {

                // --- AVATAR EN HAUT ---
                AvatarOverlay(avatarVM: avatarVM)
                    .padding(.top, 10)

                // --- OBJECTIFS DU JOUR ---
                section("Progression du jour",
                        progress: avg(of: dailyGoals),
                        tint: .blue)

                cardList(dailyGoals)

                // --- OBJECTIFS HEBDO ---
                section("Objectifs de la semaine",
                        progress: avg(of: weeklyGoals),
                        tint: .green)
                cardList(weeklyGoals)

                // --- OBJECTIFS MENSUELS ---
                section("Objectifs du mois",
                        progress: avg(of: monthlyGoals),
                        tint: .purple)
                cardList(monthlyGoals)
            }
            .padding(.top, 20)
            .padding(.horizontal)
        }
        .onAppear {
            avatarVM.speak("Voici ton tableau de bord 📊")
        }
    }

    // MARK: UI réutilisable

    func section(_ title: String, progress: Double, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2.bold())

            ProgressView(value: progress)
                .tint(tint)
        }
    }

    func cardList(_ list: [Goal]) -> some View {
        VStack(spacing: 12) {
            ForEach(list) { goal in
                HStack {
                    Text(goal.icon)
                    Text(goal.title).font(.headline)
                    Spacer()
                    Text("\(Int(goal.progress * 100)) %")
                        .font(.headline)
                        .foregroundColor(goal.progress >= 0.8 ? .yellow : .gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
    }
}

