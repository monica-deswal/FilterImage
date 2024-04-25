//
//  ContentView.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var capturedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var isEditViewActive = false
    
    var body: some View {
        NavigationView {
           GeometryReader { geometry in
                VStack {
                    if let image = capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: geometry.size.width-30)
                            .padding()
                        
                        NavigationLink(destination:
                                        ImageEditView(caption: ""
                                                      , isEditing: false, image: image, isDetailViewActive: $isEditViewActive, colorFilter: "")) {
                            Image(systemName: "square.and.pencil") .foregroundColor(.cyan)
                                .font(.system(size: 70))
                        }
                    } else {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showingImagePicker.toggle()
                            }) {
                                Image(systemName: "photo.fill.on.rectangle.fill") .foregroundColor(.cyan)
                                    .font(.system(size: 70))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
           }
            .navigationBarTitle("Photo Mementos")
        }
        .foregroundColor(.red)
        .foregroundColor(.cyan)
        .sheet(isPresented: $showingImagePicker) {
            ImageCaptureViewModel(capturedImage: self.$capturedImage, sourceType: .photoLibrary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

