//
//  RatingView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/09/01.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
            Image(systemName: "star.fill")
            Image(systemName: "star.fill")
            Image(systemName: "star.fill")
            Image(systemName: "star.fill")
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3.5)
    }
}
