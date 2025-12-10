import SwiftUI

struct AddGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var avatarVM: AvatarViewModel
    @Binding var goals: [Goal]
    
    // Champs principaux
    @State private var title = ""
    @State private var icon = "🎯"
    @State private var type: GoalType = .quantite
    @State private var target: String = ""
    @State private var unit = ""
    @State private var frequency: GoalFrequency = .quotidien
    
    // Sous-objectifs
    @State private var wantsSubGoals = false
    @State private var subGoals: [SubGoal] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // Titre
                    Text("Nouvel objectif")
                        .font(.largeTitle.bold())
                    
                    Group {
                        TextField("Titre de l’objectif", text: $title)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Icône (emoji)", text: $icon)
                            .textFieldStyle(.roundedBorder)
                        
                        Picker("Type", selection: $type) {
                            ForEach(GoalType.allCases, id: \.self) { t in
                                Text(t.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        TextField("Cible (nombre)", text: $target)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Unité (km, €, h...)", text: $unit)
                            .textFieldStyle(.roundedBorder)
                        
                        Picker("Fréquence", selection: $frequency) {
                            ForEach(GoalFrequency.allCases, id: \.self) { f in
                                Text(f.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Divider()
                    
                    // PROPOSITION DE SOUS-OBJECTIFS
                    if frequency != .quotidien {
                        Toggle("Créer des sous-objectifs ?", isOn: $wantsSubGoals)
                            .onChange(of: wantsSubGoals) { newValue in
                                if newValue {
                                    generateSubGoals()
                                    avatarVM.speak("J’ai généré des sous-objectifs ! Tu peux les modifier si tu veux 😄")
                                } else {
                                    subGoals.removeAll()
                                }
                            }
                    }
                    
                    // ÉDITION DES SOUS-OBJECTIFS
                    if wantsSubGoals {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Sous-objectifs")
                                .font(.headline)
                            
                            ForEach(subGoals.indices, id: \.self) { i in
                                VStack(alignment: .leading) {
                                    TextField("Nom du sous-objectif", text: $subGoals[i].title)
                                        .textFieldStyle(.roundedBorder)
                                    
                                    TextField("Cible", value: $subGoals[i].target, format: .number)
                                        .textFieldStyle(.roundedBorder)
                                    
                                    Button("Supprimer") {
                                        subGoals.remove(at: i)
                                    }
                                    .foregroundColor(.red)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            
                            Button {
                                addManualSubGoal()
                            } label: {
                                Label("Ajouter un sous-objectif", systemImage: "plus.circle")
                                    .foregroundColor(.blue)
                            }
                            .padding(.top, 10)
                        }
                    }
                    
                    Spacer(minLength: 30)
                    
                    // BOUTON AJOUTER
                    Button(action: saveGoal) {
                        Text("Créer l’objectif")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(title.isEmpty ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(title.isEmpty)
                    
                }
                .padding()
            }
            .onAppear {
                avatarVM.speak("Créons un nouvel objectif ensemble 👌")
            }
        }
    }
    
    // MARK: - Génération automatique
    
    func generateSubGoals() {
        switch frequency {
        case .hebdomadaire:
            subGoals = (1...7).map { i in
                SubGoal(
                    title: "Jour \(i)",
                    target: (Double(target) ?? 0) / 7,
                    progress: 0,
                    unit: unit,
                    frequency: .quotidien
                )
            }
        case .mensuel:
            subGoals = (1...4).map { i in
                SubGoal(
                    title: "Semaine \(i)",
                    target: (Double(target) ?? 0) / 4,
                    progress: 0,
                    unit: unit,
                    frequency: .hebdomadaire
                )
            }
        case .annuel:
            subGoals = (1...12).map { i in
                SubGoal(
                    title: "Mois \(i)",
                    target: (Double(target) ?? 0) / 12,
                    progress: 0,
                    unit: unit,
                    frequency: .mensuel
                )
            }
        default:
            break
        }
    }
    
    func addManualSubGoal() {
        subGoals.append(
            SubGoal(title: "Nouveau sous-objectif", target: 0, progress: 0, unit: unit, frequency: frequency)
        )
    }
    
    // MARK: - Enregistrer l'objectif
    
    func saveGoal() {
        
        let newGoal = Goal(
            title: title,
            icon: icon,
            type: type,
            target: Double(target) ?? 0,
            unit: unit,
            frequency: frequency,
            storedProgressValue: 0,
            progress: 0,
            subGoals: wantsSubGoals ? subGoals : []
        )
        
        goals.append(newGoal)
        
        avatarVM.speak("Ton objectif a bien été créé 🎯")
        
        dismiss()
    }
}

