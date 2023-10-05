//
//  StopwatchButton.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI

struct StopwatchButton: View {
    let text: String
    let backgroundColor: Color
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
