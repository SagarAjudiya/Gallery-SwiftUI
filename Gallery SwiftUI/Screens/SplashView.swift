//
//  SplashView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct SplashView: View {
    
    // MARK: - Variable
    @State private var isActive = false
    @State private var isloginView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.imgSplash)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isloginView = SessionManager.shared.userId == nil
                    isActive = !isloginView
                }
            }
            .navigationDestination(isPresented: $isloginView) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $isActive) {
                HomeView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
}

#Preview {
    SplashView()
}
