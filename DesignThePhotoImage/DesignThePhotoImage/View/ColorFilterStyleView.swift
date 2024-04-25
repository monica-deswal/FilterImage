//
//  ColorFilterStyle.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import SwiftUI

struct ColorFilterStyle: View {
    
    let capturedImage: UIImage
    @Binding var colorFilter: String
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(Array(ImagesColorModel.imageColorTypeArray), id: \.key) { key, value in
                    
                    ZStack {
                        Image(uiImage: capturedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 130, height: 100)
                            .overlay {
                                Rectangle()
                                    .fill( Color(hex: value).opacity(0.3))
                            }
                        VStack {
                            Text(key.uppercased())
                                .background(Color.black.opacity(0.3))
                                .foregroundColor(.white)
                        }
                    }.onTapGesture {
                        DispatchQueue.global().async {
                            colorFilter = value
                        }
                    }

                }
            }
            .padding()
        }
    }
}

struct ColorFilterStyle_Previews: PreviewProvider {
    static var previews: some View {
        ColorFilterStyle(capturedImage: UIImage(systemName: "image1")!
                         , colorFilter: .constant("FFFFFF"))
    }
}
