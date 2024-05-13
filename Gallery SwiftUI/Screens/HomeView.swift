//
//  HomeView.swift
//  Gallery SwiftUI
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    // MARK: - Variable
    @State private var isProfileView = false
    @State private var isLoading = false
    @State private var imageList = [Hit]()
    
    @StateObject private var viewModel = GalleryViewModel()
    
    private var reqModel = GalleryRequest()
    private var currentPage = 1
    private let gridItem = [GridItem(.flexible(), spacing: 18),
                            GridItem(.flexible(), spacing: 18)]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 12) {
                    Button {
                        isProfileView = true
                    } label: {
                        Image(.imgMore)
                    }
                    .frame(alignment: .leading)
                    
                    Text("Images")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.appGrey)
                
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 12) {
                        ForEach(imageList) { item in
                            if let url = URL(string: item.largeImageURL ?? "") {
                                KFImage(url)
                                    .placeholder {
                                        Image(.imgPlaceHolder).resizable() }
                                    .resizable()
                                    .cancelOnDisappear(true)
                                    .frame(height: 360)
                                    .onAppear {
                                        if item == imageList.last {
                                            reqModel.page += 1
                                            viewModel.getGalleryListApi(request: reqModel, showLoader: { isLoading in
                                            }, apiClosure: { status, message, data in
                                                imageList.append(contentsOf: data?.hits ?? [])
                                                SessionManager.shared.galleryObject = imageList
                                            })
                                        }
                                    }
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.appGrey)
            }
            
            .navigationDestination(isPresented: $isProfileView) {
                ProfileView()
                    .navigationBarBackButtonHidden()
            }
            .onAppear {
                getImages()
            }
            
            if isLoading {
                LoadingView()
            }
        }
    }
    
}

#Preview {
    HomeView()
}

extension HomeView {
    
    private func getImages() {
        if let galleryList = SessionManager.shared.galleryObject {
            self.isLoading = false
            self.imageList = galleryList
        } else {
            viewModel.getGalleryListApi(request: reqModel, showLoader: { isLoading in
                self.isLoading = isLoading
            }, apiClosure: { status, message, data in
                imageList = data?.hits ?? []
                SessionManager.shared.galleryObject = imageList
            })
        }
    }
    
}
