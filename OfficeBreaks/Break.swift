//
//  Break.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 22/09/2023.
//

import Foundation
import SwiftUI

/// An object representing a break.
class Break: ObservableObject {
    
    /// The name of the break. Used as the title of the break notification.
    @Published private(set) var title: String
    
    /// The break's subtitle.
    @Published private(set) var subtitle: String
    
    /// A short description of what to do during the break.
    @Published private(set) var description: String
    
    /// How often the break should occur in seconds.
    @Published private(set) var recurrenceTime: Int
    
    /// The break's theme color.
    @Published private(set) var color: Color
    
    /// The system image name of the break's icon.
    @Published private(set) var systemImageName: String
    
    /// Creates a break with the given parameters.
    /// - Parameters:
    ///   - title: The name of the break. Used as the title of the break notification.
    ///   - subtitle: The break's subtitle.
    ///   - description: A short description of what to do during the break.
    ///   - recurrenceTime: How often the break should occur in seconds.
    ///   - color: The break's theme color.
    ///   - systemImageName: The system image name of the break's icon.
    init(title: String, subtitle: String, description: String, recurrenceTime: Int, color: Color, systemImageName: String) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.recurrenceTime = recurrenceTime
        self.color = color
        self.systemImageName = systemImageName
    }
    
    /// An example Break
    /// Ideal for use in previews.
    static let example = Break(
        title: "Test Break",
        subtitle: "This is a test break. Good luck.",
        description: "This is an example description for the example break. Hope all is well.",
        recurrenceTime: 15*60,
        color: .red,
        systemImageName: "film")
    
    /// A screen break.
    /// Occurs every sixty minutes.
    static let screen = Break(
        title: "Screen Break",
        subtitle: "Time to give your eyes a rest",
        description: "Spend 20 seconds looking at something around 20 feet away.",
        recurrenceTime: 20*60,
        //recurrenceTime: 8,
        color: .blue,
        systemImageName: "eye")
    
    /// A desk break.
    /// Occurs every twenty minutes.
    static let desk = Break(
        title: "Desk Break",
        subtitle: "Time to get away from your desk",
        description: "Spend 10 minutes doing light physical activity away from your desk.",
        recurrenceTime: 60*60,
        //recurrenceTime: 2,
        color: .green,
        systemImageName: "figure.walk")
}
