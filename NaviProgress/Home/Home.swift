import SwiftUI

struct Home: View {
    
    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]
    
    // MARK: - Regroupement automatiques des sous-objectifs
    
    var dailySubGoals: [SubGoal] {
        goals.flatMap { $0.subGoals }.filter { $0.frequency == .quotidien }
    }
    
    var weeklySubGoals: [SubGoal] {
        goals.flatMap { $0.subGoals }.filter { $0.frequency == .hebdomadaire }
    }
    
    var monthlySubGoals: [SubGoal] {
        goals.flatMap { $0.subGoals }.filter { $0.frequency == .mensuel }
    }
    
    // Objectifs "top-level"
    var dailyGoalsTop: [Goal] {
        goals.filter { $0.frequency == .quotidien && $0.subGoals.isEmpty }
    }
    
    var weeklyGoalsTop: [Goal] {
        goals.filter { $0.frequency == .hebdomadaire && $0.subGoals.isEmpty }
    }
    
    var monthlyGoalsTop: [Goal] {
        goals.filter { $0.frequency == .mensuel && $0.subGoals.isEmpty }
    }
    
    // STRUCTURE UTILITAIRE
    struct ProgressItem {
        let title: String
        let percent: Double
    }
    
    func itemsFor(_ sub: [SubGoal], _ top: [Goal]) -> [ProgressItem] {
        var arr: [ProgressItem] = []
        
        sub.forEach { sg in
            arr.append(ProgressItem(title: sg.title, percent: sg.progress))
        }
        top.forEach { g in
            arr.append(ProgressItem(title: g.title, percent: g.progress))
        }
        
        return arr
    }
    
    func avg(_ items: [ProgressItem]) -> Double {
        guard !items.isEmpty else { return 0 }
        return items.map { $0.percent }.reduce(0, +) / Double(items.count)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                // Avatar
                AvatarHeader(avatarVM: avatarVM)
                    .padding(.top, 10)
                
                // ---------- JOUR ----------
                let dayItems = itemsFor(dailySubGoals, dailyGoalsTop)
                
                HomeSection(
                    title: "Objectifs du jour",
                    progress: avg(dayItems),
                    color: .blue
                )
                
                VStack(spacing: 12) {
                    ForEach(dayItems.indices, id: \.self) { i in
                        GoalCard(title: dayItems[i].title, percent: dayItems[i].percent)
                    }
                }
                
                // ---------- SEMAINE ----------
                let weekItems = itemsFor(weeklySubGoals, weeklyGoalsTop)
                
                HomeSection(
                    title: "Objectifs de la semaine",
                    progress: avg(weekItems),
                    color: .green
                )
                
                VStack(spacing: 12) {
                    ForEach(weekItems.indices, id: \.self) { i in
                        GoalCard(title: weekItems[i].title, percent: weekItems[i].percent)
                    }
                }
                
                // ---------- MOIS ----------
                let monthItems = itemsFor(monthlySubGoals, monthlyGoalsTop)
                
                HomeSection(
                    title: "Objectifs du mois",
                    progress: avg(monthItems),
                    color: .purple
                )
                
                VStack(spacing: 12) {
                    ForEach(monthItems.indices, id: \.self) { i in
                        GoalCard(title: monthItems[i].title, percent: monthItems[i].percent)
                    }
                }
                
                Spacer(minLength: 40)
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            avatarVM.speak("Voici ton tableau de bord 📊 Continue comme ça !")
        }
    }
}

