//
//  NewsView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var newsVM = NewsViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
        
        newsVM.getNotifications()
    }
    
    var body: some View {
        VStack {
            NewsTitleView()
            
            List() {
                ForEach(newsVM.notifications ?? [], id: \.self) { notification in
                    NavigationLink(destination: PDFView(link: notification.link)) {
                        Text(self.formatTitle(title: notification.title))
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .padding(.vertical, 10)
                    }
                }
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func formatTitle(title: String) -> String {
        let index = title.range(of: "2020 ")
        
        if index != nil {
            let r = title.index(title.startIndex, offsetBy: 11)..<title.endIndex
            
            let formattedStr = title[r]
            return String(formattedStr)
        }
        
        return title
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct NewsTitleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
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
            
            HStack {
                Spacer()
                
                Text("News & Advisories")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}
