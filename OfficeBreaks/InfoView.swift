//
//  SettingsView.swift
//  EyeSaver
//
//  Created by Tom Curnow on 17/08/2023.
//

import SwiftUI

/// A view to showing information about the benefits of office breaks.
struct InfoView: View {
    
    var body: some View {

        List {
            Section ("EYE HEALTH"){
                Text("Increased screen time may lead to dry eyes and headaches. To combat this, healthcare professionals recommend using the 20-20-20 rule. This means every 20 minutes you should take a break from your screen and look at something about 20 feet away for 20 seconds.")
                Link("More Information", destination: URL(string: "https://www.sbs.nhs.uk/article/16681/Working-from-home-and-looking-after-your-eyes")!)
            }
            
            Section ("SITTING"){
                Text("There is increased evidence that sitting down too much can be a risk to your health. Healthcare professionals recommend breaking up long periods of sitting time with at least light activity.")
                Link("More Information", destination: URL(string: "https://www.nhs.uk/live-well/exercise/exercise-guidelines/why-sitting-too-much-is-bad-for-us/")!)
            }
        }
        .navigationTitle("Break Benefits")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
