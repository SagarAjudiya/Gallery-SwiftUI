//
//  LoginView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Variable
    @State private var isHomeView = false
    @State var appUser = AppUser()
    
    var body: some View {
        VStack(spacing: 60) {
            Image(.imgAuth)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                googleSignIn()
            } label: {
                HStack {
                    Image(.imgGoogle)
                        .frame(width: 36, height: 36)
                    
                    Text("Sign in with Google")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
            }
            .padding()
            .background(Color.appNorway)
            .clipShape(.capsule)
        }
        .navigationDestination(isPresented: $isHomeView) {
            HomeView()
                .navigationBarBackButtonHidden()
        }
    }
    
}

#Preview {
    LoginView()
}

extension LoginView {
    
    func googleSignIn() {
        GoogleSignIn.signIn { result in
            switch result {
            case .success(let user):
                SessionManager.shared.userId = user.userID
                appUser.email = user.profile?.email
                appUser.name = user.profile?.name
                appUser.givenName = user.profile?.givenName
                appUser.profilePicUrl = user.profile?.imageURL(withDimension: 320)
                SessionManager.shared.appUserObject = appUser
                isHomeView = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
