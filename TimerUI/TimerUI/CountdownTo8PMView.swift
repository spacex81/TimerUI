import SwiftUI

struct CountdownTo8PMView: View {
    @State private var timeRemaining: (hours: Int, minutes: Int, seconds: Int) = (0, 0, 0)
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text("Countdown to 8 PM")
                .font(.headline)
                .padding(.bottom, 20)
            
            Text("\(timeRemaining.hours)h \(timeRemaining.minutes)m \(timeRemaining.seconds)s")
                .font(.largeTitle)
                .bold()
                .monospacedDigit()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                )
            
//            Button("Reset Timer") {
//                calculateTimeRemaining()
//            }
//            .padding(.top, 20)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func calculateTimeRemaining() {
        // Current time in KST
        let now = Date()
        let kstTimeZone = TimeZone(identifier: "Asia/Seoul")!
        let calendar = Calendar.current
        var components = calendar.dateComponents(in: kstTimeZone, from: now)
        
        // Set the target time to 8 PM today
        components.hour = 20
        components.minute = 0
        components.second = 0
        
        if let today8PM = calendar.date(from: components), today8PM > now {
            // Time remaining until 8 PM today
            updateTimeRemaining(to: today8PM)
        } else {
            // If 8 PM has already passed, calculate for tomorrow
            var tomorrowComponents = components
            tomorrowComponents.day! += 1 // Move to tomorrow
            if let tomorrow8PM = calendar.date(from: tomorrowComponents) {
                updateTimeRemaining(to: tomorrow8PM)
            }
        }
    }
    
    private func updateTimeRemaining(to targetDate: Date) {
        let now = Date()
        let interval = targetDate.timeIntervalSince(now)
        
        if interval > 0 {
            let hours = Int(interval) / 3600
            let minutes = (Int(interval) % 3600) / 60
            let seconds = Int(interval) % 60
            timeRemaining = (hours, minutes, seconds)
        } else {
            timeRemaining = (0, 0, 0) // Target time reached
        }
    }
    
    private func startTimer() {
        calculateTimeRemaining()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            calculateTimeRemaining()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    CountdownTo8PMView()
        .preferredColorScheme(.dark)
}
