//
//  ContactDetailView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct ContactDetailView: View {
    var nationalContact: NationalContact?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Contacts")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.top, 15)
            
            Divider()
                .frame(height: 0.5)
                .background(Color("blueTheme"))
                .offset(y: -5)
            
            if nationalContact != nil {
                VStack {
                    HStack {
                        Button(action: {
                            self.call(contactNumber: "+91-11-23978046")
                        }) {
                            Image(systemName: "phone.circle")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                            
                            Text(nationalContact?.contactNumber ?? "")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    .padding(10)
                    
                    HStack {
                        Button(action: {
                            self.call(contactNumber: "+91-11-23978046")
                        }) {
                            Image(systemName: "phone.circle")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                            
                            Text("\(nationalContact?.tollFree ?? "") (Toll-free)")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(10)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                        
                        Text(nationalContact?.email ?? "")
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding(10)
                    
                    HStack(spacing: 20) {
                        HStack(spacing: 5) {
                            Image("facebook_icon")
                                .frame(width: 44, height: 44)
                                .offset(x: -4)
                            
                            Text(self.getUsername(socialMediaLink: nationalContact?.facebook ?? "MoHFWIndia"))
                                .font(.subheadline)
                        }
                        
                        HStack(spacing: 5) {
                            Image("twitter_icon")
                                .frame(width: 44, height: 44)
                                .padding(.leading, 20)
                            
                            Text(self.getUsername(socialMediaLink: nationalContact?.twitter ?? "MoHFW_INDIA"))
                                .font(.subheadline)
                        }
                    }
                    .padding(11)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
//                .frame(width: UIScreen.main.bounds.width - 30)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 5, y: 5)
                .padding(.bottom, 10)
            } else {
                HStack {
                    Spacer()
                    
                    Text("Data not available.")
                        .font(.body)
                        .padding(.top, 75)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func call(contactNumber: String) {
        // validation of phone number not included
        let dash = CharacterSet(charactersIn: "-")
        
        let cleanString =
            contactNumber.trimmingCharacters(in: dash)
        
        let tel = "tel://"
        let formattedString = tel + cleanString
        let url: NSURL = URL(string: formattedString)! as NSURL
        
        UIApplication.shared.open(url as URL)
    }
    
    func getUsername(socialMediaLink link: String) -> String {
        let arrayStr = link.components(separatedBy: "/")
        if arrayStr.count > 0 {
            return arrayStr.last!
        }
        return ""
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView()
    }
}
