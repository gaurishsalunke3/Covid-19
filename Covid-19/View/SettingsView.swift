//
//  SettingsView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    let settings = ["About App", "Terms & Conditions", "Notification", "Help", "Logout"]
    
    var body: some View {
        VStack(alignment: .leading) {
            SettingsTitleView()
            
            ForEach (settings, id: \.self) { setting in
                ZStack {
                    NavigationLink(destination: Text(setting)) {
                        HStack {
                            Text("\(setting)")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .offset(x: 0, y: -1)
                            
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    }
                    
                    Divider()
                        .padding(.leading, 20)
                        .offset(y: 25)
                    
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsTitleView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Settings")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}
