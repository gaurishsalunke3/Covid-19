//
//  StateDetailView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct StateDetailView: View {
    var stateDetail: Regional
    
    var body: some View {
        VStack {
            StateDetailTitleView(stateName: stateDetail.stateName)
            
            HStack {
                Text(stateDetail.stateName)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            
            Divider()
                .frame(height: 1)
                .background(Color("blueTheme"))
                .padding(.horizontal, 20)
                .offset(y: -5)
            
            
            VStack(alignment: .leading, spacing: 25) {
                HStack {
                    Text("Confirmed Cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.confirmedTotalCases.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
                HStack {
                    Text("Confirmed Indian Cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.confirmedCasesIndian.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
                HStack {
                    Text("Confirmed Foreign Cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.confirmedCasesForeign.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
                HStack {
                    Text("Active Cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.activeCases.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.yellow)
                }
                
                HStack {
                    Text("Deaths: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.deaths.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                
                HStack {
                    Text("Recovered: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(stateDetail.discharged.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Divider()
                .padding()
            
            VStack {
                HStack {
                    Text("Hospitals")
                        .font(.headline)
                    
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                    
                    Spacer()
                    
                    Text((stateDetail.hospital?.totalHospitals ?? 0).getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
                HStack {
                    Text("Available Beds")
                        .font(.headline)
                    
                    Image(systemName: "bed.double")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text((stateDetail.hospital?.totalBeds ?? 0).getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                }
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            if stateDetail.contact?.contactNumber != nil {
                VStack{
                    Button(action: {
                        
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "phone.circle")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text(stateDetail.contact?.contactNumber ?? "")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, (stateDetail.contact?.contactNumber.count)! < 4 ? 50 : 20)
                        .padding(.vertical, 15)
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct StateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StateDetailView(stateDetail: Regional(stateName: "Maharashtra", confirmedCasesIndian: 487, discharged: 42, deaths: 24, confirmedCasesForeign: 3, contact: StateContact(stateName: "Maharashtra", contactNumber: "+91-20-26127394"), hospital: StateHospital(stateName: "Maharashtra", ruralHospitals: 273, ruralBeds: 12398, urbanHospitals: 438, urbanBeds: 39048, totalHospitals: 711, totalBeds: 51446, updatedDate: "2015-12-31T00:00:00.000Z")))
    }
}

struct StateDetailTitleView: View {
    var stateName: String
    
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

