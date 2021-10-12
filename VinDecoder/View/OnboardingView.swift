//
//  OnboardingView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            WelcomeCardView()
            InfoCardView()
            TutorialCardView()
            ReadyCardView()
        }
        .tabViewStyle(.page)
       
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
