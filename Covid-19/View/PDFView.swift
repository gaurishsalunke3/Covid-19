//
//  PDFView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import WebKit

struct PDFView: View {
    var link: String
    
    var body: some View {
        VStack(spacing: 0) {
            PDFViewerTitleView()
            
            WebView(request: self.openPDF(urlString: link))
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func openPDF(urlString: String) -> URLRequest {
        guard let url = URL(string: urlString) else {
            fatalError("Bad URL.")
        }
        
        return URLRequest(url: url)
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView(link: "https://www.mohfw.gov.in/pdf/DistrictWiseList324.pdf")
    }
}

struct PDFViewerTitleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
