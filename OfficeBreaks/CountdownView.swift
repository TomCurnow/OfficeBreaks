//
//  CountdownView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI

/// A view showing the given time in a readable format.
/// Used by ``Working View`` to show the time remaining until
/// the next break.
struct CountdownView: View {
    
    /// The break to be had once `time` is 0.
    var nextBreak: Break
    
    /// The time remaining (seconds) until `nextbreak` is active.
    var time: Int

    var body: some View {
        VStack (spacing: 0){
            Spacer()
            
            Circle()
                .foregroundStyle(.ultraThinMaterial)
                .overlay(
                    Text(convertSecondsToMinuteSec(seconds: time))
                        .font(
                            .system(size: 74)
                            .monospacedDigit()
                        )
                        .fontWeight(.thin)
                )
                .padding(.bottom)
            
            HStack {
                Text("Until:")
                    .bold()
                Spacer()
                Image(systemName: nextBreak.systemImageName)
                    .foregroundColor(nextBreak.color)
                Text(nextBreak.title)
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .padding(.top)
            
            Spacer()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(timeAsString(seconds: time))
    }

    
    /// Provides a readable string in the "minutes : seconds" format from the given time in seconds.
    /// - Parameter seconds: The time in seconds.
    /// - Returns: A readable string in the minutes:seconds format.
    func convertSecondsToMinuteSec(seconds:Int) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from:TimeInterval(seconds))!
        return formattedString
    }

    /// Provides a readable string in the format of "x minutes and y seconds until your z break".
    /// Used for accessibility purposes.
    /// - Parameter seconds: The time in seconds.
    /// - Returns: a readable string in the format of "x minutes and y seconds until your z break".
    func timeAsString(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute]
        
        let minutesString = formatter.string(from:TimeInterval(seconds))! + "minutes"
        
        let secondsOnly = seconds % 60
        let secondsString = secondsOnly == 0 ? "" : "and \(secondsOnly) seconds"
        
        return "\(minutesString) \(secondsString) until your \(nextBreak.title)"
    }
}

#Preview {
    CountdownView(nextBreak: Break.example, time: 847)
}
