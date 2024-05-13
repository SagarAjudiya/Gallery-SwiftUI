//
//  ProfileView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Variable
    @Environment(\.dismiss) var dismiss
    @State private var isLoginView = false
    
    private let user = SessionManager.shared.appUserObject
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(.imgClose)
                    }
                }
                
                HStack {
                    Spacer()
                    Image(.imgGoogle)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .overlay {
                            RoundedRectangle(cornerRadius: 120)
                                .stroke(lineWidth: 16)
                                .foregroundColor(.white)
                        }
                    Spacer()
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 10) {
                    TextView(placeHolder: "Name", value: user?.name ?? "")
                    
                    Rectangle()
                        .frame(height: 4)
                        .foregroundStyle(.appGrey)
                    
                    TextView(placeHolder: "Email", value: user?.email ?? "")
                    
                    Rectangle()
                        .frame(height: 4)
                        .foregroundStyle(.appGrey)
                    
                    TextView(placeHolder: "Given Name", value: user?.givenName ?? "")
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                .padding(.bottom)
                
                Button {
                    SessionManager.shared.userId = nil
                    SessionManager.shared.appUserObject = nil
                    SessionManager.shared.galleryObject = nil
                    GoogleSignIn.signOut()
                    isLoginView = true
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.appNorway)
                .clipShape(.capsule)
            }
            .padding([.horizontal, .bottom])
            .background(Color.appGrey)
            .navigationDestination(isPresented: $isLoginView) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
