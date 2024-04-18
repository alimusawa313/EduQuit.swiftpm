import SwiftUI

struct MuteButton: View {
    @State private var isMuted = false
    
    var body: some View {
        Button(action: {
            self.isMuted.toggle()
            if self.isMuted{
                StartButtonSound.stopSound()
            }else{
                StartButtonSound.playMusic(selectedSound: "main-song_")
            }
        }) {
            Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.3.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding(20)
                .background(isMuted ? Color.red : Color.green)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        
    }
}

#Preview {
    MuteButton()
}
