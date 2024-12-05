import SwiftUI

struct TimerDemoView: View {
    @State private var timerRunning: Bool = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 30) {
            // Timer Display
            Text(formatTime(elapsedTime))
                .font(.system(size: 60, weight: .bold, design: .monospaced))
                .padding()
            
            // Timer Control Buttons
            HStack(spacing: 20) {
                Button(action: {
                    if timerRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(timerRunning ? "Pause" : "Start")
                        .font(.title2)
                        .frame(width: 100, height: 50)
                        .background(timerRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: resetTimer) {
                    Text("Reset")
                        .font(.title2)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
    
    // Timer Functions
    func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            elapsedTime += 0.1
        }
    }
    
    func pauseTimer() {
        timerRunning = false
        timer?.invalidate()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timerRunning = false
        elapsedTime = 0
    }
    
    // Format elapsed time into minutes:seconds:milliseconds
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - floor(time)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

#Preview {
    TimerDemoView()
}
