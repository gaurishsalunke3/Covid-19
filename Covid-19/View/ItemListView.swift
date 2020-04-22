//
//  ItemListView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/20/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    @State private var tabIndex: Int = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack {
                    ItemListTitleView(title: tabIndex == 0 ? "Countrywise" : "Statewise")
                    
                    ListTopTabBarView(tabIndex: $tabIndex)
                }
                .background(Color("blueTheme"))
                
                if tabIndex == 0 {
                    CountryListView()
                } else {
                    StatesListView()
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            //            if self.showLoading {
            //                ProgressView(showProgress: Binding<self.$showLoading.wrappedValue>)
            //            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}

struct ItemListTitleView: View {
    var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.white)
                        .font(.title)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}

struct ListTopTabBarView: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Text("Country")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.vertical, 10)
                        .foregroundColor(Color.white.opacity(self.tabIndex == 0 ? 1 : 0.3))
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .onTapGesture {
                    self.tabIndex = 0
                }
                
                Rectangle()
                    .fill(Color.black.opacity(self.tabIndex == 0 ? 1 : 0))
                    .frame(height: 3)
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Text("States")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.vertical, 10)
                        .foregroundColor(Color.white.opacity(self.tabIndex == 1 ? 1 : 0.5))
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .onTapGesture {
                    self.tabIndex = 1
                }
                
                Rectangle()
                    .fill(Color.black.opacity(self.tabIndex == 1 ? 1 : 0))
                    .frame(height: 3)
            }
        }
        .padding(.top, -10)
    }
}
