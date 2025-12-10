import SwiftUI

struct Tracking: View {
    @ObservedObject var avatarVM: AvatarViewModel

    var body: some View {
        Text("Page Tracking")
            .onAppear {
                avatarVM.speak("C'est ici que tu suivras tes progrès 📈")
            }
    }
}

