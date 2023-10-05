//
//  CountdownView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI

struct CountdownView: View {
    var nextBreak: Break
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

    
    func convertSecondsToMinuteSec(seconds:Int) -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from:TimeInterval(seconds))!
        return formattedString
    }
    
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
