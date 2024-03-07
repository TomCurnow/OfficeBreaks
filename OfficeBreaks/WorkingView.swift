//
//  WorkingView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI
import UserNotifications

/// A view to manage and display the break countdown.
/// Shown while the user is working.
struct WorkingView: View {
    /// The dismiss action for the current environment.
    @Environment(\.dismiss) var dismiss
    
    /// The scene phase of the current environment.
    @Environment(\.scenePhase) var scenePhase
    
    /// A stored boolean value indicating whether the users has enabled screen breaks.
    @AppStorage("screenBreaksEnabled") private var screenBreaksEnabled = true
    
    /// A stored boolean value indicating whether the user has enabled desk breaks.
    @AppStorage("deskBreaksEnabled") private var deskBreaksEnabled = true
    
    /// A boolean value indicating whether the break sheet is showing.
    @State private var showingBreakSheet = false
    
    /// A boolean value indicating whether the current scene phase is active.
    @State private var isActive = true
    
    /// A boolean value indicating whether the stop timer alert is showing.
    @State private var showingAlert = false
    
    /// The order number of the next break to be had by the user.
    /// Used by `nextBreak` to calculate which break should be next.
    @State private var breakNumber = 0
    
    /// The end date of `breaktimer`.
    @State private var timerEndDate = Date.now.addingTimeInterval(Double(0))
    
    /// The time (seconds) until `breakTimer` finishes.
    @State private var timeRemaining: Int = 5
    
    /// A timer used to trigger breaks.
    let breakTimer = Timer.publish(every: 1, tolerance: 0.4, on: .main, in: .common).autoconnect()
    
    /// The next break the user will have.
    private var nextBreak: Break {
        if breakNumber % 3 == 0 {
            deskBreaksEnabled ? Break.desk : Break.screen
        } else {
            screenBreaksEnabled ? Break.screen : Break.desk
        }
    }
    
    /// Adds a push notification to remind the user when the next break starts.
    func addBreakNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = nextBreak.title
            content.subtitle = nextBreak.subtitle
            content.sound = UNNotificationSound.default

            let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: timerEndDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh!")
                    }
                }
            }
        }
    }
    
    /// Starts the countdown for the next break.
    func startWork() {
        breakNumber += 1
        if nextBreak.title == Break.desk.title && screenBreaksEnabled {
            timeRemaining = nextBreak.recurrenceTime - (2 * Break.screen.recurrenceTime)
        } else {
            timeRemaining = nextBreak.recurrenceTime
        }
        timerEndDate = Date.now.addingTimeInterval(Double(timeRemaining))
        addBreakNotification()
    }
    
    /// Stops the countdown while a break is active.
    func stopWork() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        breakTimer.upstream.connect().cancel()
        dismiss()
    }
    
    var body: some View {
        ZStack {
            VStack {
                CountdownView(nextBreak: nextBreak, time: timeRemaining)
                    .padding()
                
                StopwatchButton(text: "Stop", backgroundColor: .red) {
                   showingAlert = true
                }
                .padding()
                .accessibilityHint("Stop the current timer.")
            }
            .frame(maxWidth: 400)
        }
        .frame(maxWidth: .infinity)
        .onReceive(breakTimer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                let timeTillEnd = Int(timerEndDate.timeIntervalSinceNow)
                timeRemaining = max(timeTillEnd,0)
                
                if timeRemaining == 0 {
                    showingBreakSheet = true
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
        .onAppear{
            startWork()
        }
        .sheet(isPresented: $showingBreakSheet) {
            BreakView(nextBreak, onDismiss: startWork)
                .interactiveDismissDisabled()
        }
        .alert("Stop the timer", isPresented: $showingAlert) {
            Button("Stop", role: .destructive) { stopWork() }
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    WorkingView()
}
