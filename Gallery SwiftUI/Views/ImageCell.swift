//
//  ImageCell.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct ImageCell: View {
    var body: some View {
        VStack {
            Image(.dummy)
                .resizable()
                .frame(height: 360)
        }
    }
}

#Preview {
    ImageCell()
}
