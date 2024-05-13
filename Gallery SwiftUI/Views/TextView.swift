//
//  TextView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct TextView: View {
    
    // MARK: - Variable
    let placeHolder: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeHolder)
                .font(.system(size: 16))
                .foregroundStyle(Color.secondary)
            Text(value)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }
}

#Preview {
    TextView(placeHolder: "Name", value: "Sagar")
}
