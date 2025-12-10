import SwiftUI
import Combine   // ⭐ OBLIGATOIRE ⭐

class AvatarViewModel: ObservableObject {
    
    @Published var fullText: String = ""
    @Published var displayedText: String = ""
    
    private var timer: Timer?
    
    func speak(_ message: String) {
        timer?.invalidate()
        displayedText = ""
        fullText = message
        
        var index = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if index < message.count {
                let char = Array(message)[index]
                self.displayedText.append(char)
                index += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

