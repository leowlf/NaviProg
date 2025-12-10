import SwiftUI

struct AvatarOverlay: View {
    
    @ObservedObject var avatarVM: AvatarViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 8) {
                
                // AVATAR ICON
                Text("🤖")
                    .font(.system(size: 46)) // taille légèrement réduite
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                
                // Bulle de dialogue
                AvatarCommentBubble(message: avatarVM.displayedText)
            }
            .padding(.bottom, 90) // ← remonte l’avatar pour qu’il ne bloque plus les inputs
        }
        .animation(.easeInOut(duration: 0.3), value: avatarVM.displayedText)
    }
}
