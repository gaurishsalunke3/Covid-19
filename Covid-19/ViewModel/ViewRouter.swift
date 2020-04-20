//
//  ViewRouter.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    @Published var currentViewIndex = 0
    @Published var currentTabIndex = 0
    
    @Published var x: CGFloat = 0
    @Published var count: CGFloat = 0
    @Published var screen = UIScreen.main.bounds.width - 30
    @Published var op: CGFloat = 0
}
