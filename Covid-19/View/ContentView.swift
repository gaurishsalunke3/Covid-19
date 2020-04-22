//
//  ContentView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                if viewRouter.currentViewIndex == 0 {
                    NavigationView {
                        HomeView()
                    }
                } else if viewRouter.currentViewIndex == 1 {
                    NavigationView {
                        ItemListView()
                    }
                } else if viewRouter.currentViewIndex == 2 {
                    NavigationView {
                        NewsView()
                    }
                } else if viewRouter.currentViewIndex == 3 {
                    NavigationView {
                        SettingsView()
                    }
                }
            }
            
            CustomTabs(index: $viewRouter.currentViewIndex)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTabs: View {
    @Binding var index: Int
    
    var body: some View {
        HStack {
            Button(action: {
                self.index = 0
            }) {
                Image(systemName: "house")
                    .font(.system(size: 22, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.3))
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 1
            }) {
                Image(systemName: "list.bullet")
                    .font(.system(size: 22, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.3))
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 2
            }) {
                Image(systemName: "speaker")
                    .font(.system(size: 22, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color.black.opacity(self.index == 2 ? 1 : 0.3))
            
            Spacer(minLength: 0)
            
            Button(action: {
                self.index = 3
            }) {
                Image(systemName: "gear")
                    .font(.system(size: 22, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color.black.opacity(self.index == 3 ? 1 : 0.3))
        }
        .padding(EdgeInsets(top: 20, leading: 40, bottom: 30, trailing: 40))
        .background(Color("blueTheme"))
    }
}
