import SwiftUI

struct AvatarHeader: View {
    @ObservedObject var avatarVM: AvatarViewModel

    var body: some View {
        VStack(spacing: 6) {

            // Avatar image
            Image(systemName: "robot")
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
                .padding(8)

            // Speech bubble
            AvatarCommentBubble(message: avatarVM.displayedText)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
    }
}

