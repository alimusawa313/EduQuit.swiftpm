import SwiftUI

struct SoundWaveBg: View {
    let minHeight: CGFloat
    let maxHeight: CGFloat
    let width: CGFloat
    let numberOfRectangles = 8
    let waveColors: [Color] = [.red, .orange, .yellow, .green, .mint, .blue, .pink, .purple]
    @State private var heights: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(0..<numberOfRectangles, id: \.self) { index in
                SoundWaveRectangle(height: heights.isEmpty ? CGFloat.random(in: minHeight...maxHeight) : heights[index],
                                   width: width,
                                   color: waveColors[index % waveColors.count])
            } 
        }
        .onAppear {
            startAnimating()
        }
    }
    
    func startAnimating() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            withAnimation(Animation.easeInOut(duration: 3).repeatForever()) {
                heights = (0..<numberOfRectangles).map { _ in
                    CGFloat.random(in: 50...300)
                }
            }
        }
    }
}

struct SoundWaveRectangle: View {
    let height: CGFloat
    let width: CGFloat
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: width, height: height)
            .foregroundColor(color)
    }
}

struct SoundWaveBg_Previews: PreviewProvider {
    static var previews: some View {
        SoundWaveBg(minHeight: 100, maxHeight: 200, width: 45)
    }
}
