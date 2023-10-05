//
//  ContentView.swift
//  DeskDoctor
//
//  Created by Tom Curnow on 21/09/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var screenBreakHint = "Occur every 20 minutes. During a screen break, spend 20 seconds looking at something around 20 feet away."
    private var deskBreakHint = "Occur every 60 minutes. During a desk break, spend around 10 minutes doing light physical activity away from your desk."
    
    @AppStorage("screenBreaksEnabled") private var screenBreaksEnabled = true
    @AppStorage("deskBreaksEnabled") private var deskBreaksEnabled = true
    
    @State private var showingWorkingView = false
    private var noBreaksSelected: Bool { !(screenBreaksEnabled || deskBreaksEnabled) }
     
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Toggle(isOn: $screenBreaksEnabled.animation(), label: {
                            HStack {
                                Image(systemName: "eye")
                                    .foregroundColor(.blue)
                                Text("Screen Breaks")
                            }
                        })
                        .accessibilityHint(screenBreakHint)
                    } footer: {
                        Text(screenBreakHint)
                            .accessibilityHidden(true)
                    }

                    Section {
                        Toggle(isOn: $deskBreaksEnabled.animation(), label: {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .foregroundColor(.green)
                                Text("Desk Breaks")
                            }
                        })
                        .accessibilityHint(deskBreakHint)
                    } footer: {
                        Text(deskBreakHint)
                            .accessibilityHidden(true)
                    }

                    Section {
                        NavigationLink("Break Benefits") {
                            InfoView()
                        }
                    }
                }
                
                VStack {
                    StopwatchButton(text:"Start", backgroundColor: noBreaksSelected ? .black : .green) {
                        showingWorkingView = true
                    }
                    .disabled(noBreaksSelected)
                    .padding()
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle("Office Breaks")
            .navigationDestination(isPresented: $showingWorkingView) {
                WorkingView().navigationBarBackButtonHidden(true)
            }
        }
        .frame(maxWidth: 1024)
    }
}

#Preview {
    ContentView()
}
