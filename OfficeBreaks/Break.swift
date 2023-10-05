//
//  Break.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 22/09/2023.
//

import Foundation
import SwiftUI

class Break: ObservableObject {
    @Published private(set) var title: String
    @Published private(set) var subtitle: String
    @Published private(set) var description: String
    @Published private(set) var recurrenceTime: Int
    @Published private(set) var color: Color
    @Published private(set) var systemImageName: String
    
    init(title: String, subtitle: String, description: String, recurrenceTime: Int, color: Color, systemImageName: String) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.recurrenceTime = recurrenceTime
        self.color = color
        self.systemImageName = systemImageName
    }
    
    static let example = Break(
        title: "Test Break",
        subtitle: "This is a test break. Good luck.",
        description: "This is an example description for the example break. Hope all is well.",
        recurrenceTime: 15*60,
        color: .red,
        systemImageName: "film")
    
    static let screen = Break(
        title: "Screen Break",
        subtitle: "Time to give your eyes a rest",
        description: "Spend 20 seconds looking at something around 20 feet away.",
        recurrenceTime: 20*60,
        //recurrenceTime: 8,
        color: .blue,
        systemImageName: "eye")
    
    static let desk = Break(
        title: "Desk Break",
        subtitle: "Time to get away from your desk",
        description: "Spend 10 minutes doing light physical activity away from your desk.",
        recurrenceTime: 60*60,
        //recurrenceTime: 2,
        color: .green,
        systemImageName: "figure.walk")
}
