//
//  BreakView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 22/09/2023.
//

import SwiftUI

struct BreakView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase

    let currentBreak: Break
    let onDismiss: () -> Void
    
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
