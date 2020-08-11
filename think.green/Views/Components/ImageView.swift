//
//  ImageView.swift
//  think.green
//
//  Created by Julian Kreller on 10.08.20.
//  Copyright © 2020 Julian Kreller. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: StrapiAPIImageLoader

    init(from urlString: String) {
        imageLoader = StrapiAPIImageLoader(imageUrlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: (imageLoader.data != nil ? UIImage(data: imageLoader.data!) : UIImage())!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
