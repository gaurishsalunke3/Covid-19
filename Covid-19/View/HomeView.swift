//
//  HomeView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewRouter = ViewRouter()
    @ObservedObject var homeVM = HomeViewModel()
    
    init() {
        homeVM.loadSummaryData()
//        homeVM.countries = Details.getAllCountriesSamples()
        homeVM.getIndiaContactData()
    }
    
    var body: some View {
        ZStack {
            Color.init(red: 242/255, green: 242/255, blue: 242/255)
            
            VStack {
                VStack(spacing: 10) {
                    HomeTitleView()
                    
                    TopTabBarView(tabIndex: $viewRouter.currentTabIndex)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Total Cases")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                            Text(viewRouter.currentTabIndex == 0 ? (homeVM.globalData?.cases ?? 0).getValue() : (homeVM.globalData?.indiaData?.cases ?? 0).getValue()
                            )
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 10) {
                        HStack {
                            TileView(label: "Active cases", number: viewRouter.currentTabIndex == 0 ? (homeVM.globalData?.active ?? 0) : (homeVM.globalData?.indiaData?.active ?? 0), color: Color.init(red: 255/255, green: 224/255, blue: 72/255))
                        }
                        
                        HStack(spacing: 10) {
                            TileView(label: "Deaths", number: viewRouter.currentTabIndex == 0 ? (homeVM.globalData?.deaths ?? 0) : (homeVM.globalData?.indiaData?.deaths ?? 0), color: Color.red)
                            
                            TileView(label: "Recovered", number: viewRouter.currentTabIndex == 0 ? (homeVM.globalData?.recovered ?? 0) : (homeVM.globalData?.indiaData?.recovered ?? 0), color: Color.green)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
                .background(Color("blueTheme"))
                
                if viewRouter.currentTabIndex == 0 {
                    CountryView(homeVM: homeVM)
                } else {
                    ContactDetailView(nationalContact: self.homeVM.indiaContact)
                }
                                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.init(red: 242/255, green: 242/255, blue: 242/255))
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeTitleView: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Text("Covid-19 Cases")
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 15, trailing: 20))
        .background(Color("blueTheme").edgesIgnoringSafeArea(.top))
    }
}

struct TopTabBarView: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Text("Global")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.vertical, 10)
                        .foregroundColor(Color.white.opacity(self.tabIndex == 0 ? 1 : 0.3))
                    
                    Image(systemName: "globe")
                        .foregroundColor(Color.white.opacity(self.tabIndex == 0 ? 1 : 0.3))
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .onTapGesture {
                    self.tabIndex = 0
                }
                
                Rectangle()
                    .fill(Color.white.opacity(self.tabIndex == 0 ? 1 : 0))
                    .frame(height: 3)
            }
            
            VStack(spacing: 0) {
                HStack(spacing: 20) {
                    Text("India")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.vertical, 10)
                        .foregroundColor(Color.white.opacity(self.tabIndex == 1 ? 1 : 0.5))
                    
                    Text("IN".getFlag())
                        .font(.headline)
                }
                .frame(width: UIScreen.main.bounds.width / 2)
                .onTapGesture {
                    self.tabIndex = 1
                }
                
                Rectangle()
                    .fill(Color.white.opacity(self.tabIndex == 1 ? 1 : 0))
                    .frame(height: 3)
            }
        }
        .padding(.top, -10)
    }
}

struct TileView: View {
    var label: String
    var number: Double?
    var color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text((number ?? 0).getValue())
                    .font(.system(size: 34, weight: .semibold, design: .rounded))
                
                Spacer()
            }
            .padding(.vertical, 5)
            
            Divider()
                .frame(height: 1)
                .background(Color.white)
                .padding(.horizontal, -15)
            
            HStack {
                Text(label)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                
                Spacer()
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(color)
        .cornerRadius(10)
    }
}

struct CountryView: View {
    @ObservedObject var viewRouter = ViewRouter()
    
    var homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        self.viewRouter.x = ((self.viewRouter.screen + 15) * CGFloat((self.homeVM.topCountries.count - 1) / 2)) + self.adjust()
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Top Infected countries")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.top, 15)
            
            Divider()
                .frame(height: 0.5)
                .background(Color("blueTheme"))
                .offset(y: -5)

            
            if self.homeVM.topCountries.count != 0 {
//                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(self.homeVM.topCountries, id:\.self) { country in
                            CountryCardView(countryDetail: country)
                                .offset(x: self.viewRouter.x)
                                .highPriorityGesture(DragGesture()
                                    .onChanged({ (value) in
                                        if value.translation.width > 0 {
                                            self.viewRouter.x = value.location.x
                                        } else {
                                            self.viewRouter.x = value.location.x - self.viewRouter.screen
                                        }
                                    })
                                    .onEnded({ (value) in
                                        if value.translation.width > ((self.viewRouter.screen - 80) / 2) && Int(self.viewRouter.count) != (self.check() ? self.getMid() - 1 : self.getMid()) {
                                            if value.translation.width > ((self.viewRouter.screen - 80) / 2) && Int(self.viewRouter.count) != self.getMid() {
                                                self.viewRouter.count += 1
//                                                self.updateHeight(value: Int(self.viewRouter.count))
                                                self.viewRouter.x = (self.viewRouter.screen + 15) * self.viewRouter.count
                                            } else {
                                                self.viewRouter.x = (self.viewRouter.screen + 15) * self.viewRouter.count
                                            }
                                        } else {
                                            if -value.translation.width > ((self.viewRouter.screen - 80) / 2) && -Int(self.viewRouter.count) != self.getMid() {
                                                self.viewRouter.count -= 1
//                                                self.updateHeight(value: Int(self.viewRouter.count))
                                                self.viewRouter.x = (self.viewRouter.screen + 15) * self.viewRouter.count
                                            } else {
                                                self.viewRouter.x = (self.viewRouter.screen + 15) * self.viewRouter.count
                                            }
                                        }
                                    })
                            )
                        }
                    }
                    .frame(width : UIScreen.main.bounds.width - 40)
//                    .offset(x: self.viewRouter.op)
//                }
//                .padding(.horizontal, 20)
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
        .animation(.spring())
        .onAppear {
            if self.check() {
                self.viewRouter.op = ((self.viewRouter.screen + 15) / 2)
            } else {
                self.viewRouter.op = 0
            }
            
//            let mid = self.check() ? self.getMid() - 1 : self.getMid()
//            self.homeVM.countries[mid].show = true
        }
    }
    
    func adjust() -> CGFloat {
        if self.check() {
            return ((self.viewRouter.screen + 15) / 2)
        } else {
            return 0
        }
    }
    
    func getMid() -> Int {
        self.homeVM.topCountries.count / 2
    }
    
//    func updateHeight(value : Int) {
//        var id : Int
//        if value < 0 {
//            id = -value + (self.check() ? getMid() - 1 : getMid())
//        } else {
//            id = (self.check() ? getMid() - 1 : getMid()) - value
//        }
//
//        for i in 0..<self.homeVM.countries.count {
//            self.homeVM.countries[i].show = false
//        }
//        self.homeVM.countries[id].show = true
//    }

    func check() -> Bool{
        if self.homeVM.topCountries.count % 2 == 0 {
            return true
        } else {
            return false
        }
    }
}

struct CountryCardView: View {
    var countryDetail: Details
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(countryDetail.countryName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                if countryDetail.countryInfo.countryCode != nil {
                    Text(countryDetail.countryInfo.countryCode!.getFlag())
                }
                
                Spacer()
            }
            
            Divider()
                .frame(height: 0.5)
                .background(Color("blueTheme"))
            
            HStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Active Cases")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    
                    Text(countryDetail.cases.getValue())
                        .font(.title)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Critical")
                            .font(.headline)
                        
                        Text(countryDetail.critical.getValue())
                            .font(.headline)
                            .foregroundColor(Color.yellow)
                    }
                    
                    Divider()
                        .background(Color("blueTheme"))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deaths")
                            .font(.headline)
                        
                        Text(countryDetail.deaths.getValue())
                            .font(.headline)
                            .foregroundColor(Color.red)
                    }
                    
                    Divider()
                        .background(Color("blueTheme"))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recovered")
                            .font(.headline)
                        
                        Text(countryDetail.recovered.getValue())
                            .font(.headline)
                            .foregroundColor(Color.green)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 5, y: 5)
        .padding(.bottom, 10)
    }
}
