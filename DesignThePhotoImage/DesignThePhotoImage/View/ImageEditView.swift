//
//  ImageEditView.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import SwiftUI

struct ImageEditView: View {
    
    //let capturedImage: UIImage
    @State var caption: String = ""
    @State private var isEditing: Bool = false
    @State var image: UIImage
    @Binding var isDetailViewActive: Bool
    
    @State var colorFilter: String = "#FFFFFF"
    
    
    init(caption: String, isEditing: Bool
         , image: UIImage
         , isDetailViewActive: Binding<Bool>
    , colorFilter: String) {
        self.caption = caption
        self.isEditing = isEditing
        self.image = image
        _isDetailViewActive = isDetailViewActive
        self.colorFilter = colorFilter
    }
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottom) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: geometry.size.width)
                        .overlay {
                            Rectangle()
                                .fill(Color.init(hex: colorFilter).opacity(0.6))
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
                                 , colorFilter: $colorFilter)
                
                HStack(spacing: 40) {
                    //Add text
                    Button(action: {
                        isEditing = !isEditing
                    }) {
                        Image(systemName: "note.text.badge.plus") .foregroundColor(.cyan)
                            .font(.system(size: 50))
                    }
                    
                    //Save
                    Button(action: {
                        self.applyFilter(to: image) { updatedImage in
                            self.image = updatedImage
                            self.saveToPhotos(image: self.image)
                            isDetailViewActive = true
                        }
                    }) {
                        Image(systemName: "square.and.arrow.down.on.square.fill") .foregroundColor(.cyan)
                            .font(.system(size: 40))
                    }
                    //Share
                    Button(action: {
                        
                    }) {
                        Image(systemName: "square.and.arrow.up") .foregroundColor(.cyan)
                            .font(.system(size: 40))
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
        ImageEditView(caption: ""
                      , isEditing: false
                      , image: UIImage(named: "image1")!, isDetailViewActive: .constant(false)
                      , colorFilter: "")
    }
}
