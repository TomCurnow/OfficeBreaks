//
//  BreakView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 22/09/2023.
//

import SwiftUI

/// A view to show the user the current break.
/// Displays information from ``currentBreak`` explaining what
/// the user may want to do during the break.
struct BreakView: View {
    
    /// The dismiss action for the current environment.
    @Environment(\.dismiss) var dismiss
    
    /// The scene phase of the current environment.
    @Environment(\.scenePhase) var scenePhase
    
    /// The current break the user is on.
    let currentBreak: Break
    
    /// The function to be called on dismissal of this view.
    let onDismiss: () -> Void
    
    
    /// Creates a break view with the given parameters.
    /// - Parameters:
    ///   - currentBreak: The current break the user is on.
    ///   - onDismiss: The function to be called on dismissal of this view.
    init(_ currentBreak: Break, onDismiss: @escaping () -> Void) {
        self.currentBreak = currentBreak
        self.onDismiss = onDismiss
    }
    
    var body: some View {
            VStack {
                Spacer()
                Image(systemName: currentBreak.systemImageName)
                    .font(.system(size: 50))
                    .foregroundColor(currentBreak.color)

                Text(currentBreak.title)
                    .font(.title2)
                    .padding()
                    .padding([.horizontal], 20)
                
                Text(currentBreak.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal], 20)
                
                Spacer()
                
                StopwatchButton(text: "Done", backgroundColor: .gray) {
                    dismiss()
                    onDismiss()
                }
                .padding()
            }
        }
}

#Preview {
    BreakView(Break.example, onDismiss: { })
}
