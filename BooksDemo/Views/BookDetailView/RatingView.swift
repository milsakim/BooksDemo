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
            switch rating {
            case 0..<1:
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
            case 1..<2:
                Image(systemName: "star.fill")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
            case 2..<3:
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
            case 3..<4:
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
                Image(systemName: "star")
            case 4..<5:
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
            case 5:
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
            default:
                Text("Unkown Rating")
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3.5)
    }
}
