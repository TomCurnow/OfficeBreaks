//
//  WorkingView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI
import UserNotifications

struct WorkingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("screenBreaksEnabled") private var screenBreaksEnabled = true
    @AppStorage("deskBreaksEnabled") private var deskBreaksEnabled = true
    
    @State private var showingBreakSheet = false
    @State private var isActive = true
    @State private var showingAlert = false
    @State private var breakNumber = 0
    @State private var timerEndDate = Date.now.addingTimeInterval(Double(0))
    @State private var timeRemaining: Int = 5
    let breakTimer = Timer.publish(every: 1, tolerance: 0.4, on: .main, in: .common).autoconnect()

    private var nextBreak: Break {
        if breakNumber % 3 == 0 {
            deskBreaksEnabled ? Break.desk : Break.screen
        } else {
            screenBreaksEnabled ? Break.screen : Break.desk
        }
    }
    
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
                .presentationDetents([.medium])
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
