import SwiftUI

struct AddGoalView: View {
    
    @Binding var goals: [Goal]
    @ObservedObject var avatarVM: AvatarViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var icon = "🔥"
    @State private var type: GoalType = .quantite
    @State private var target: Double = 1
    @State private var unit = ""
    @State private var frequency: GoalFrequency = .quotidien
    
    // Liste d’icônes simples
    let icons = ["🔥","📚","🏋️‍♂️","🧠","💰","📈","🧘","🏃‍♂️"]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section("Nom & Icône") {
                    TextField("Nom de l'objectif", text: $title)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(icons, id: \.self) { ic in
                                Text(ic)
                                    .font(.largeTitle)
                                    .padding(6)
                                    .background(ic == icon ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        icon = ic
                                    }
                            }
                        }
                    }
                }
                
                Section("Type d'objectif") {
                    Picker("Type", selection: $type) {
                        ForEach(GoalType.allCases, id: \.self) { t in
                            Text(t.rawValue).tag(t)
                        }
                    }
                }
                
                Section("Cible") {
                    HStack {
                        Text("Objectif :")
                        TextField("Valeur", value: $target, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                    
                    TextField("Unité (km, pages, min…)", text: $unit)
                }
                
                Section("Fréquence") {
                    Picker("Fréquence", selection: $frequency) {
                        ForEach(GoalFrequency.allCases, id: \.self) { f in
                            Text(f.rawValue).tag(f)
                        }
                    }
                }
            }
            .navigationTitle("Nouvel objectif")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        addGoal()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") { dismiss() }
                }
            }
        }
    }
    
    func addGoal() {
        let newGoal = Goal(
            title: title,
            icon: icon,
            type: type,
            target: target,
            unit: unit,
            frequency: frequency,
            progress: 0.0
        )
        
        goals.append(newGoal)
        avatarVM.speak("Ton nouvel objectif est créé 🎯")
        dismiss()
    }
}

