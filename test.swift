import SwiftUI

struct test: View {
    @State private var isStarted = false
    @State private var startTime: Date?
    @State private var reactionTime: TimeInterval?
    
    @State private var elapsedTime: TimeInterval = 0
    @State private var isTimerRunning = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            if isStarted {
                Text("Tap as fast as you can!")
                    .font(.title)
                    .padding()
                
                Text("Elapsed Time: \(formattedElapsedTime) ms")
                    .padding()
                
                Button("Stop") {
                    let endTime = Date()
                    reactionTime = endTime.timeIntervalSince(startTime!)
                    isStarted = false
                    stopTimer()
                    elapsedTime = 0
                }
                
            } else {
                Button("Start") {
                    startTime = Date()
                    isStarted = true
                    startTimer()
                }
            }
            
            if let reactionTime = reactionTime {
                Text("Your reaction time: \(String(format: "%.2f", reactionTime)) seconds")
                    .font(.headline)
                    .padding()
            }
        }
    }
    
    private var formattedElapsedTime: String {
        let milliseconds = Int(elapsedTime * 1000)
        return "\(milliseconds)"
    }
    
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
            elapsedTime += 0.001
        }
    }
    
    private func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview{
    test()
}
