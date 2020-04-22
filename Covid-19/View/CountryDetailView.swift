//
//  CountryDetailView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/22/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    var countryDetail: Details
    
    var body: some View {
        VStack {
            CountryDetailTitleView()
            
            HStack {
                Text(countryDetail.countryName)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                Spacer()
                
                if countryDetail.countryInfo.countryCode != nil {
                    Text(countryDetail.countryInfo.countryCode!.getFlag())
                        .font(.title)
                } else {
                    Image(systemName: "flag")
                        .font(.title)
                }
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
                    Text("Total Cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.cases.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    
                    Text("( + \(countryDetail.todayCases.getValue()) )*")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                
                HStack {
                    Text("Total deaths: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.deaths.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)

                    Text("( + \(countryDetail.todayDeaths.getValue()) )*")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }
                
                HStack {
                    Text("Recovered: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.recovered.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                }
                
                HStack {
                    Text("Active cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.active.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.yellow)
                }
                
                HStack {
                    Text("Critical cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.critical.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }

                HStack {
                    Text("Tests: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(countryDetail.tests.getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }

                HStack {
                    Text("Per million cases: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text((countryDetail.casesPerOneMillion ?? 0).getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }
                
                HStack {
                    Text("Per million deaths: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text((countryDetail.deathsPerOneMillion ?? 0).getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }

                
                HStack {
                    Text("Per million tests: ")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text((countryDetail.testsPerOneMillion ?? 0).getValue())
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }

            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(countryDetail: Details(countryName: "USA", countryInfo: CountryInfo(countryCode: "US"), cases: 142735, todayCases: 275, deaths: 2489, todayDeaths: 5, recovered: 4562, active: 135684, critical: 2970, tests: 3861596, casesPerOneMillion: 431, deathsPerOneMillion: 8, testsPerOneMillion: 11666))
    }
}

struct CountryDetailTitleView: View {
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
