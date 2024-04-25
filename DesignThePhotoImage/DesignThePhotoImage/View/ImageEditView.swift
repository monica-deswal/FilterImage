//
//  ImageEditView.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import SwiftUI

struct ImageEditView: View {
    
    @State var caption: String = ""
    @State private var isEditing: Bool = false
    @Binding var image: UIImage?
    @Binding var showingImagePicker: Bool
    @State var colorFilter: String = ""
    
    @State private var isShareSheetPresented = false

    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottom) {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay {
                            Rectangle()
                                .fill((colorFilter.isEmpty) ? Color.clear : Color.init(hex: colorFilter).opacity(0.2))
                        }
                    
                    if isEditing {
                        TextField("Add Text", text: $caption)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(8)
                            .padding()
                    }
                }
                
                ColorFilterStyle(capturedImage: image
                                 , colorFilter: $colorFilter, selectedColor: "")
                
                HStack(spacing: 40) {
                    //Add text
                    Button(action: {
                        isEditing = !isEditing
                    }) {
                        Image(systemName: "note.text.badge.plus") .foregroundColor(.cyan)
                            .font(.system(size: 25))
                    }
                    
                    //Save
                    Button(action: {
                        self.applyFilter(to: image!) { updatedImage in
                            self.image = updatedImage
                            self.saveToPhotos(image: self.image!)
                        }
                    }) {
                        Image(systemName: "square.and.arrow.down.on.square.fill") .foregroundColor(.cyan)
                            .font(.system(size: 20))
                    }
                    //Share
                    Button(action: {
                        self.isShareSheetPresented.toggle()
                    }) {
                        Image(systemName: "square.and.arrow.up") .foregroundColor(.cyan)
                            .font(.system(size: 20))
                    }.sheet(isPresented: $isShareSheetPresented) {
                        // Content to share
                        ActivityView(activityItems: [image])
                    }
                }
            }
        }
        .navigationBarTitle("Fine-tune Photo")
        .navigationBarBackButtonHidden(true)
    }
}



struct ImageEditView_Previews: PreviewProvider {
    static var previews: some View {
        ImageEditView(image: .constant(UIImage(named: "image1")!)
                      , showingImagePicker: .constant(false))
    }
}
