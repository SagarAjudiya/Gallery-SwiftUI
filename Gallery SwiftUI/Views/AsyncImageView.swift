//
//  AsyncImageView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI

struct AsyncImageView: View {
    
    // MARK: - Variable
    @State private var image: UIImage? = nil
    let imageUrl: String
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                // You can replace the placeholder with your custom placeholder image
                Image(.imgPlaceHolder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            loadImage(from: imageUrl)
        }
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        ImageCache.shared.fetchImage(from: url) { fetchedImage in
            DispatchQueue.main.async {
                self.image = fetchedImage
            }
        }
    }
}


#Preview {
    AsyncImageView(imageUrl: "")
}
