//
//  StopwatchButton.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI

/// A view displaying a stopwatch style button.
struct StopwatchButton: View {
    
    /// The text to display on the button.
    let text: String
    
    /// The button's background color.
    let backgroundColor: Color
    
    /// The action to be performed when the button is pressed.
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(text)
                .font(.title3)
                .foregroundColor(backgroundColor)
                .brightness(0.2)
                .padding([.horizontal], 50)
                .padding([.vertical], 25)
                .background(backgroundColor.brightness(-0.5))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    StopwatchButton(text: "Start", backgroundColor: .black)
}
