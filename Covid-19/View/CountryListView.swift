//
//  CountryListView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/20/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var statesVM = StatesViewModel()
    
    init() {
        statesVM.loadCountryData()
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                //                StatesListTitleView()
                VStack(spacing: 0) {
                    List() {
                        ForEach(statesVM.countries ?? [], id: \.self) { country in
                            NavigationLink(destination: CountryDetailView(countryDetail: country)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Text(country.countryName)
                                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            
                                            if country.countryInfo.countryCode != nil {
                                                Text(country.countryInfo.countryCode!.getFlag())
                                                    .font(.title)
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Text("Total cases")
                                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                            
                                            Text(country.cases.getValue())
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .foregroundColor(.red)
                                            
                                            Text("( + \(country.todayCases.getValue()) )")
                                                .font(.headline)
                                                .foregroundColor(Color.red)
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
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
