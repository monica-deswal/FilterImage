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
    
    var body: some View {
        NavigationView {
           GeometryReader { geometry in
                VStack {
                    if let image = capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                showingImagePicker = true
                            }, label: {
                                Image(systemName: "square.and.pencil") .foregroundColor(.cyan)
                                    .font(.system(size: 30))
                            })
                            
                            Button(action: {
                                capturedImage = nil
                            }, label: {
                                Image(systemName: "photo.fill.on.rectangle.fill") .foregroundColor(.cyan)
                                    .font(.system(size: 30))
                            })
                        }
                    } else {
                        
                        ImageCaptureViewModel(capturedImage: self.$capturedImage, sourceType: .camera)
                    }
                }
           }
            .navigationBarTitle("Photo Mementos")
        }
        .sheet(isPresented: $showingImagePicker) {
            ImageEditView(image: $capturedImage , showingImagePicker: $showingImagePicker)
        }
        .foregroundColor(.cyan)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

