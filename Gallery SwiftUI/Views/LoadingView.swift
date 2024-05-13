//
//  LoadingView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(edges: .all)
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.appNorway)
                .scaleEffect(2)
        }

    }
}

#Preview {
    LoadingView()
}
