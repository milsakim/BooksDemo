//
//  BookDetailView.swift
//  BooksDemo
//
//  Created by HyeJee Kim on 2022/08/24.
//

import SwiftUI

struct BookDetailView: View {
    @StateObject private var bookDetailViewModel: BookDetailViewModel
    
    init(isbn: String) {
        _bookDetailViewModel = StateObject(wrappedValue: BookDetailViewModel(isbn: isbn))
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: bookDetailViewModel.bookDetail?.image ?? "Unknown")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 240, height: 320)
                    .background(Color.red)
                    .padding()
                    
                    Text(bookDetailViewModel.bookDetail?.title ?? "Unknown")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(bookDetailViewModel.bookDetail?.authors ?? "Unknown")
                    
                    RatingView(rating: Double(bookDetailViewModel.bookDetail?.rating ?? "unknown") ?? 0)
                        .padding()
                    
                    Button("GET") {
                        print("--- button tapped ---")
                    }
                    .padding()
                    
                    BookInformationRowView(title: "Description", content: bookDetailViewModel.bookDetail?.desc ?? "Unknown", alignment: .leading)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            BookInformationRowView(title: "YEAR", content: bookDetailViewModel.bookDetail?.year ?? "?", alignment: .center)
                                .padding()
                            Divider()
                            BookInformationRowView(title: "LANGUAGE", content: bookDetailViewModel.bookDetail?.language ?? "?", alignment: .center)
                                .padding()
                            Divider()
                            BookInformationRowView(title: "PAGES", content: bookDetailViewModel.bookDetail?.pages ?? "?", alignment: .center)
                                .padding()
                            Divider()
                            BookInformationRowView(title: "PUBLISHER", content: bookDetailViewModel.bookDetail?.publisher ?? "?", alignment: .center)
                                .padding()
                            Divider()
                            BookInformationRowView(title: "ISBN13", content: bookDetailViewModel.bookDetail?.isbn13 ?? "?", alignment: .center)
                                .padding()
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                bookDetailViewModel.fetchBookDetailInformation()
            }
            .opacity(bookDetailViewModel.bookDetail != nil ? 1 : 0)
            
            ProgressView()
                .opacity(bookDetailViewModel.bookDetail != nil ? 0 : 1)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(isbn: "Test")
    }
}
