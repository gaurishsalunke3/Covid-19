//
//  StatesListView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct StatesListView: View {
    //    @Binding private var showLoading: Bool!
    
    @ObservedObject var statesVM = StatesViewModel()
    
    init() {
        statesVM.loadStateData()
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                //                StatesListTitleView()
                
                VStack(spacing: 0) {
                    List() {
                        ForEach(statesVM.states ?? [], id: \.self) { state in
                            NavigationLink(destination: StateDetailView(stateDetail: state)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(state.stateName)
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        
                                        HStack {
                                            Text("Total cases")
                                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                            
                                            Text(state.confirmedTotalCases.getValue())
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                            }
                        }
                    }
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
}

struct StatesListView_Previews: PreviewProvider {
    static var previews: some View {
        StatesListView()
    }
}

struct StatesListTitleView: View {
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
            
            Text("States")
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .offset(x: -15)
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}
